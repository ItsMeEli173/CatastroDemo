import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/validation/person_name_input_formatter.dart';
import '../../../core/validation/validators.dart';
import '../../../core/widgets/feedback.dart';
import '../../../core/widgets/section_card.dart';
import '../data/farmer_providers.dart';
import '../domain/entities/farmer.dart';

/// Formulario de alta y edición de agricultores.
class FarmerFormPage extends ConsumerWidget {
  const FarmerFormPage({this.farmerId, super.key});

  final String? farmerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = farmerId;
    if (id == null) return const _FarmerForm();
    final farmer = ref.watch(farmerProvider(id));
    return farmer.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(title: const Text('Agricultor')),
        body: Center(child: Text(error.toString())),
      ),
      data: (data) {
        if (data == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Agricultor')),
            body: const Center(child: Text('El agricultor no existe.')),
          );
        }
        return _FarmerForm(farmer: data);
      },
    );
  }
}

class _FarmerForm extends ConsumerStatefulWidget {
  const _FarmerForm({this.farmer});

  final Farmer? farmer;

  @override
  ConsumerState<_FarmerForm> createState() => _FarmerFormState();
}

class _FarmerFormState extends ConsumerState<_FarmerForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstName;
  late final TextEditingController _lastName;
  late final TextEditingController _document;
  late final TextEditingController _phone;
  late final TextEditingController _email;
  late final TextEditingController _locality;
  late final TextEditingController _address;
  late final TextEditingController _notes;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final farmer = widget.farmer;
    _firstName = TextEditingController(text: farmer?.firstName ?? '');
    _lastName = TextEditingController(text: farmer?.lastName ?? '');
    _document = TextEditingController(text: farmer?.documentNumber ?? '');
    _phone = TextEditingController(text: farmer?.phone ?? '');
    _email = TextEditingController(text: farmer?.email ?? '');
    _locality = TextEditingController(text: farmer?.locality ?? '');
    _address = TextEditingController(text: farmer?.address ?? '');
    _notes = TextEditingController(text: farmer?.notes ?? '');

    if (farmer == null) {
      _loadNextCode();
    }
  }

  Future<void> _loadNextCode() async {
    final code = await ref.read(farmerRepositoryProvider).nextCode();
    if (mounted && _document.text.isEmpty) {
      setState(() {
        _document.text = code;
      });
    }
  }

  @override
  void dispose() {
    for (final controller in [
      _firstName,
      _lastName,
      _document,
      _phone,
      _email,
      _locality,
      _address,
      _notes,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    final now = DateTime.now().toUtc();
    final existing = widget.farmer;
    final farmer = Farmer(
      id: existing?.id ?? const Uuid().v4(),
      firstName: Validators.normalizePersonName(_firstName.text),
      lastName: Validators.normalizePersonName(_lastName.text),
      documentNumber: _document.text,
      phone: _phone.text,
      email: _email.text,
      locality: _locality.text,
      address: _address.text,
      notes: _notes.text,
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );
    final success = await runGuarded(
      context,
      () => ref.read(farmerRepositoryProvider).save(farmer),
    );
    if (!mounted) return;
    setState(() => _saving = false);
    if (success) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.farmer != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar agricultor' : 'Nuevo agricultor'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SectionCard(
              title: 'Datos personales',
              icon: Icons.person_outline,
              child: Column(
                children: [
                  TextFormField(
                    controller: _firstName,
                    decoration: const InputDecoration(labelText: 'Nombre *'),
                    textCapitalization: TextCapitalization.words,
                    inputFormatters: const [PersonNameInputFormatter()],
                    validator: (value) => Validators.requiredName(
                      value,
                      message: 'Ingresa el nombre.',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _lastName,
                    decoration: const InputDecoration(labelText: 'Apellido *'),
                    textCapitalization: TextCapitalization.words,
                    inputFormatters: const [PersonNameInputFormatter()],
                    validator: (value) => Validators.requiredName(
                      value,
                      message: 'Ingresa el apellido.',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _document,
                    decoration: const InputDecoration(
                      labelText: 'Código / Documento *',
                      helperText: 'Código correlativo autogenerado',
                    ),
                    textCapitalization: TextCapitalization.characters,
                  ),
                ],
              ),
            ),
            SectionCard(
              title: 'Contacto y ubicación',
              icon: Icons.contact_phone_outlined,
              child: Column(
                children: [
                  TextFormField(
                    controller: _phone,
                    decoration: const InputDecoration(labelText: 'Teléfono'),
                    keyboardType: TextInputType.phone,
                    validator: (value) => Validators.optionalPhone(value),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(labelText: 'Correo'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => Validators.optionalEmail(value),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _locality,
                    decoration: const InputDecoration(labelText: 'Localidad'),
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _address,
                    decoration: const InputDecoration(labelText: 'Dirección'),
                    textCapitalization: TextCapitalization.sentences,
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
              label: Text(_saving ? 'Guardando…' : 'Guardar agricultor'),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
