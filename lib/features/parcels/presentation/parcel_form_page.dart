import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/di/core_providers.dart';
import '../../../core/formatting/formatters.dart';
import '../../../core/media/photo_picker_service.dart';
import '../../../core/validation/validators.dart';
import '../../../core/widgets/feedback.dart';
import '../../../core/widgets/section_card.dart';
import '../../farmers/data/farmer_providers.dart';
import '../../parcel_owners/data/parcel_owner_providers.dart';
import '../../parcel_owners/domain/entities/parcel_owner.dart';
import '../data/parcel_providers.dart';
import '../domain/entities/parcel.dart';

enum AreaUnit { hectares, squareMeters }

/// Formulario de alta y edición de parcelas con soporte de:
/// - Código autogenerado correlativo
/// - Asociación obligatoria/restringida a un agricultor existente
/// - Toggle de unidad declarada (ha <-> m²)
/// - Captura y visualización de una imagen por parcela
class ParcelFormPage extends ConsumerWidget {
  const ParcelFormPage({this.parcelId, super.key});

  final String? parcelId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = parcelId;
    if (id == null) return const _ParcelForm();
    final parcel = ref.watch(parcelProvider(id));
    return parcel.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(title: const Text('Parcela')),
        body: Center(child: Text(error.toString())),
      ),
      data: (data) {
        if (data == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Parcela')),
            body: const Center(child: Text('La parcela no existe.')),
          );
        }
        return _ParcelForm(parcel: data);
      },
    );
  }
}

class _ParcelForm extends ConsumerStatefulWidget {
  const _ParcelForm({this.parcel});

  final Parcel? parcel;

  @override
  ConsumerState<_ParcelForm> createState() => _ParcelFormState();
}

class _ParcelFormState extends ConsumerState<_ParcelForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _code;
  late final TextEditingController _name;
  late final TextEditingController _declaredArea;
  late final TextEditingController _notes;

  AreaUnit _selectedUnit = AreaUnit.squareMeters;
  String? _selectedFarmerId;
  String? _imagePath;
  String? _tempPickedImageSource;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final parcel = widget.parcel;
    _code = TextEditingController(text: parcel?.code ?? '');
    _name = TextEditingController(text: parcel?.name ?? '');

    final initialAreaM2 = parcel?.declaredAreaM2;
    if (initialAreaM2 != null) {
      _declaredArea = TextEditingController(
        text: Formatters.plainNumber(initialAreaM2),
      );
      _selectedUnit = AreaUnit.squareMeters;
    } else {
      _declaredArea = TextEditingController();
    }

    _notes = TextEditingController(text: parcel?.notes ?? '');
    _imagePath = parcel?.imagePath;

    if (parcel == null) {
      _loadNextCode();
    } else {
      _loadExistingOwner(parcel.id);
    }
  }

  Future<void> _loadNextCode() async {
    final nextCode = await ref.read(parcelRepositoryProvider).nextCode();
    if (mounted && _code.text.isEmpty) {
      setState(() {
        _code.text = nextCode;
      });
    }
  }

  Future<void> _loadExistingOwner(String parcelId) async {
    final owners = await ref.read(parcelOwnerRepositoryProvider).findByParcel(parcelId);
    if (owners.isNotEmpty && mounted) {
      setState(() {
        _selectedFarmerId = owners.first.farmerId;
      });
    }
  }

  @override
  void dispose() {
    _code.dispose();
    _name.dispose();
    _declaredArea.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _onUnitChanged(AreaUnit newUnit) {
    if (_selectedUnit == newUnit) return;
    final currentVal = Validators.parsePlainDecimal(_declaredArea.text);
    setState(() {
      _selectedUnit = newUnit;
      if (currentVal != null) {
        if (newUnit == AreaUnit.squareMeters) {
          // ha -> m2
          final m2 = currentVal * 10000;
          _declaredArea.text = m2 % 1 == 0 ? m2.toInt().toString() : m2.toStringAsFixed(2);
        } else {
          // m2 -> ha
          final ha = currentVal / 10000;
          _declaredArea.text = ha.toStringAsFixed(4).replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '');
        }
      }
    });
  }

  Future<void> _pickImage(PhotoSource source) async {
    try {
      final picked = await ref.read(photoPickerServiceProvider).pick(source);
      if (picked != null && mounted) {
        setState(() {
          _tempPickedImageSource = picked;
        });
      }
    } catch (e) {
      if (mounted) showFailure(context, e);
    }
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_selectedFarmerId == null) {
      showMessage(context, 'Debes seleccionar un agricultor para asociar la parcela.');
      return;
    }

    setState(() => _saving = true);
    final now = DateTime.now().toUtc();
    final existing = widget.parcel;
    final parcelId = existing?.id ?? const Uuid().v4();

    // Copiar foto al almacenamiento permanente si se seleccionó una nueva
    String? finalImagePath = _imagePath;
    if (_tempPickedImageSource != null) {
      final copied = await ref.read(photoStorageProvider).copyFrom(_tempPickedImageSource!);
      if (copied != null) {
        if (_imagePath != null && _imagePath != copied) {
          await ref.read(photoStorageProvider).deleteRelative(_imagePath!);
        }
        finalImagePath = copied;
      }
    }

    // Calcular área declarada normalizada a m²
    final rawNumber = Validators.parsePlainDecimal(_declaredArea.text);
    double? declaredAreaM2;
    if (rawNumber != null) {
      declaredAreaM2 = _selectedUnit == AreaUnit.hectares ? rawNumber * 10000 : rawNumber;
    }

    final parcel = Parcel(
      id: parcelId,
      code: _code.text.trim(),
      name: _name.text,
      declaredAreaM2: declaredAreaM2,
      calculatedAreaM2: existing?.calculatedAreaM2,
      status: existing?.status ?? ParcelStatus.draft,
      imagePath: finalImagePath,
      notes: _notes.text,
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );

    if (!mounted) return;
    final success = await runGuarded(
      context,
      () async {
        await ref.read(parcelRepositoryProvider).save(parcel);

        // Guardar o actualizar la relación del agricultor
        final currentOwners = await ref.read(parcelOwnerRepositoryProvider).findByParcel(parcelId);
        final existingLink = currentOwners.isNotEmpty ? currentOwners.first : null;
        if (existingLink == null) {
          await ref.read(parcelOwnerRepositoryProvider).save(
                ParcelOwner(
                  id: const Uuid().v4(),
                  parcelId: parcelId,
                  farmerId: _selectedFarmerId!,
                  ownershipPercentage: 100.0,
                  createdAt: now,
                  updatedAt: now,
                ),
              );
        } else if (existingLink.farmerId != _selectedFarmerId) {
          await ref.read(parcelOwnerRepositoryProvider).delete(existingLink.id);
          await ref.read(parcelOwnerRepositoryProvider).save(
                ParcelOwner(
                  id: const Uuid().v4(),
                  parcelId: parcelId,
                  farmerId: _selectedFarmerId!,
                  ownershipPercentage: existingLink.ownershipPercentage ?? 100.0,
                  createdAt: now,
                  updatedAt: now,
                ),
              );
        }
      },
    );

    if (!mounted) return;
    setState(() => _saving = false);
    if (success) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.parcel != null;
    final farmersAsync = ref.watch(farmersProvider(''));

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar parcela' : 'Nueva parcela'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SectionCard(
              title: 'Identificación',
              icon: Icons.landscape_outlined,
              child: Column(
                children: [
                  TextFormField(
                    controller: _code,
                    decoration: const InputDecoration(
                      labelText: 'Código *',
                      helperText: 'Código correlativo autogenerado',
                    ),
                    textCapitalization: TextCapitalization.characters,
                    validator: (value) => Validators.requiredCode(
                      value,
                      message: 'Ingresa el código de la parcela.',
                      maxLength: 40,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(
                      labelText: 'Nombre o referencia (opcional)',
                    ),
                    textCapitalization: TextCapitalization.words,
                  ),
                ],
              ),
            ),
            SectionCard(
              title: 'Agricultor titular',
              icon: Icons.person_outline,
              child: farmersAsync.when(
                loading: () => const LinearProgressIndicator(),
                error: (e, _) => Text('Error al cargar agricultores: $e'),
                data: (farmers) {
                  if (farmers.isEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'No hay agricultores registrados. Debes registrar un agricultor primero.',
                          style: TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('Volver e ingresar agricultor'),
                        ),
                      ],
                    );
                  }

                  // Si solo hay uno o ninguno seleccionado, se preselecciona
                  if (_selectedFarmerId == null && farmers.isNotEmpty && !isEditing) {
                    _selectedFarmerId = farmers.first.id;
                  }

                  return DropdownButtonFormField<String>(
                    initialValue: farmers.any((f) => f.id == _selectedFarmerId) ? _selectedFarmerId : null,
                    decoration: const InputDecoration(
                      labelText: 'Selecciona agricultor *',
                      helperText: 'La parcela quedará asociada a este agricultor',
                    ),
                    items: farmers.map((farmer) {
                      final doc = farmer.documentNumber != null ? ' (${farmer.documentNumber})' : '';
                      return DropdownMenuItem(
                        value: farmer.id,
                        child: Text('${farmer.fullName}$doc'),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() => _selectedFarmerId = val);
                    },
                    validator: (val) => val == null ? 'Selecciona un agricultor' : null,
                  );
                },
              ),
            ),
            SectionCard(
              title: 'Superficie declarada',
              icon: Icons.square_foot_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Unidad de medida:',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SegmentedButton<AreaUnit>(
                        segments: const [
                          ButtonSegment(
                            value: AreaUnit.hectares,
                            label: Text('ha'),
                            icon: Icon(Icons.crop_free),
                          ),
                          ButtonSegment(
                            value: AreaUnit.squareMeters,
                            label: Text('m²'),
                            icon: Icon(Icons.grid_on),
                          ),
                        ],
                        selected: {_selectedUnit},
                        onSelectionChanged: (set) => _onUnitChanged(set.first),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _declaredArea,
                    decoration: InputDecoration(
                      labelText: _selectedUnit == AreaUnit.hectares
                          ? 'Superficie declarada (ha)'
                          : 'Superficie declarada (m²)',
                      helperText: _selectedUnit == AreaUnit.hectares
                          ? 'Ingresa en hectáreas (1 ha = 10 000 m²)'
                          : 'Ingresa en metros cuadrados',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: (value) => Validators.nonNegativeDecimal(
                      value,
                      message: 'Ingresa una superficie válida.',
                    ),
                  ),
                ],
              ),
            ),
            SectionCard(
              title: 'Fotografía de la parcela',
              icon: Icons.photo_camera_outlined,
              child: Column(
                children: [
                  if (_tempPickedImageSource != null) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(_tempPickedImageSource!),
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ] else if (_imagePath != null) ...[
                    FutureBuilder<File?>(
                      future: ref.read(photoStorageProvider).resolve(_imagePath!),
                      builder: (context, snap) {
                        final file = snap.data;
                        if (file != null && file.existsSync()) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              file,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                        return const Center(
                          child: Icon(Icons.image_not_supported_outlined, size: 48),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _pickImage(PhotoSource.camera),
                          icon: const Icon(Icons.camera_alt_outlined),
                          label: const Text('Cámara'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _pickImage(PhotoSource.gallery),
                          icon: const Icon(Icons.photo_library_outlined),
                          label: const Text('Galería'),
                        ),
                      ),
                      if (_tempPickedImageSource != null || _imagePath != null) ...[
                        const SizedBox(width: 8),
                        IconButton.outlined(
                          tooltip: 'Quitar foto',
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _tempPickedImageSource = null;
                              _imagePath = null;
                            });
                          },
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            SectionCard(
              title: 'Observaciones',
              icon: Icons.notes_outlined,
              child: TextFormField(
                controller: _notes,
                decoration: const InputDecoration(
                  hintText: 'Notas adicionales (opcional)',
                ),
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _saving ? null : _save,
              icon: _saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save_outlined),
              label: Text(_saving ? 'Guardando…' : 'Guardar parcela'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
