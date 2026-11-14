import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/formatting/formatters.dart';
import '../../../core/validation/validators.dart';
import '../../../core/widgets/feedback.dart';
import '../../../core/widgets/section_card.dart';
import '../data/parcel_providers.dart';
import '../domain/entities/parcel.dart';

/// Formulario de alta y edición de parcelas.
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
  late final TextEditingController _declaredHectares;
  late final TextEditingController _notes;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final parcel = widget.parcel;
    _code = TextEditingController(text: parcel?.code ?? '');
    _name = TextEditingController(text: parcel?.name ?? '');
    _declaredHectares = TextEditingController(
      text: parcel?.declaredAreaM2 == null
          ? ''
          : Formatters.decimal(parcel!.declaredAreaM2! / 10000),
    );
    _notes = TextEditingController(text: parcel?.notes ?? '');
  }

  @override
  void dispose() {
    _code.dispose();
    _name.dispose();
    _declaredHectares.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    final now = DateTime.now().toUtc();
    final existing = widget.parcel;
    final hectares = Validators.parsePlainDecimal(_declaredHectares.text);
    final parcel = Parcel(
      id: existing?.id ?? const Uuid().v4(),
      code: _code.text.trim(),
      name: _name.text,
      declaredAreaM2: hectares == null ? null : hectares * 10000,
      calculatedAreaM2: existing?.calculatedAreaM2,
      status: existing?.status ?? ParcelStatus.draft,
      notes: _notes.text,
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );
    final success = await runGuarded(
      context,
      () => ref.read(parcelRepositoryProvider).save(parcel),
    );
    if (!mounted) return;
    setState(() => _saving = false);
    if (success) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.parcel != null;
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
                      helperText: 'Debe ser único, por ejemplo P-001',
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
                      labelText: 'Nombre o referencia',
                    ),
                    textCapitalization: TextCapitalization.words,
                  ),
                ],
              ),
            ),
            SectionCard(
              title: 'Superficie declarada',
              icon: Icons.square_foot_outlined,
              child: Column(
                children: [
                  TextFormField(
                    controller: _declaredHectares,
                    decoration: const InputDecoration(
                      labelText: 'Superficie declarada (ha)',
                      helperText: 'Opcional. Se guarda convertida a m² y se '
                          'mantiene separada de la calculada.',
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    validator: (value) => Validators.nonNegativeDecimal(
                      value,
                      message: 'Ingresa una superficie válida.',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'La superficie calculada se obtiene de los vértices con '
                      'un método geográfico aproximado; no sustituye a la '
                      'declarada.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
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
