import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/validation/validators.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/feedback.dart';
import '../data/grape_variety_providers.dart';
import '../domain/entities/grape_variety.dart';

/// Catálogo local editable de variedades de uva.
class GrapeVarietiesPage extends ConsumerStatefulWidget {
  const GrapeVarietiesPage({super.key});

  @override
  ConsumerState<GrapeVarietiesPage> createState() => _GrapeVarietiesPageState();
}

class _GrapeVarietiesPageState extends ConsumerState<GrapeVarietiesPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  bool _includeInactive = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  VarietyFilter get _filter =>
      VarietyFilter(query: _query, includeInactive: _includeInactive);

  @override
  Widget build(BuildContext context) {
    final varieties = ref.watch(grapeVarietiesProvider(_filter));
    return Scaffold(
      appBar: AppBar(title: const Text('Variedades de uva')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        icon: const Icon(Icons.add),
        label: const Text('Nueva variedad'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar por nombre, categoría o alias',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Limpiar búsqueda',
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                      ),
              ),
              textInputAction: TextInputAction.search,
              onChanged: (value) => setState(() => _query = value.trim()),
            ),
          ),
          SwitchListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            dense: true,
            title: const Text('Incluir variedades inactivas'),
            subtitle: const Text(
              'Las variedades inactivas conservan su historial, pero no se '
              'ofrecen en nuevos registros.',
            ),
            value: _includeInactive,
            onChanged: (value) => setState(() => _includeInactive = value),
          ),
          Expanded(
            child: AsyncValueView<List<GrapeVariety>>(
              value: varieties,
              isEmpty: (data) => data.isEmpty,
              emptyMessage: _query.isEmpty
                  ? 'Todavía no hay variedades registradas.'
                  : 'No se encontraron variedades con ese criterio.',
              onRetry: () => ref.invalidate(grapeVarietiesProvider(_filter)),
              builder: (data) => ListView.builder(
                padding: const EdgeInsets.only(bottom: 96),
                itemCount: data.length,
                itemBuilder: (context, index) =>
                    _VarietyTile(variety: data[index], onEdit: _openForm),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openForm([GrapeVariety? variety]) async {
    await showDialog<void>(
      context: context,
      builder: (_) => _VarietyFormDialog(variety: variety),
    );
  }
}

class _VarietyTile extends ConsumerWidget {
  const _VarietyTile({required this.variety, required this.onEdit});

  final GrapeVariety variety;
  final Future<void> Function([GrapeVariety? variety]) onEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = [
      if (variety.code != null) variety.code!,
      if (variety.category != null) variety.category!,
      if (variety.aliases != null) 'Alias: ${variety.aliases}',
    ].join(' · ');
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(
            variety.active ? Icons.eco_outlined : Icons.eco,
            color: variety.active
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline,
          ),
        ),
        title: Row(
          children: [
            Flexible(child: Text(variety.name)),
            if (!variety.active) ...[
              const SizedBox(width: 8),
              const Chip(
                label: Text('Inactiva'),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ],
        ),
        subtitle: details.isEmpty && variety.description == null
            ? null
            : Text(
                [
                  if (details.isNotEmpty) details,
                  if (variety.description != null) variety.description!,
                ].join('\n'),
              ),
        isThreeLine: variety.description != null && details.isNotEmpty,
        onTap: () => onEdit(variety),
        trailing: PopupMenuButton<String>(
          tooltip: 'Acciones',
          onSelected: (value) async {
            switch (value) {
              case 'edit':
                await onEdit(variety);
              case 'toggle':
                await _toggleActive(context, ref);
              case 'delete':
                await _delete(context, ref);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'edit', child: Text('Editar')),
            PopupMenuItem(
              value: 'toggle',
              child: Text(variety.active ? 'Desactivar' : 'Activar'),
            ),
            const PopupMenuItem(value: 'delete', child: Text('Eliminar')),
          ],
        ),
      ),
    );
  }

  Future<void> _toggleActive(BuildContext context, WidgetRef ref) async {
    final now = DateTime.now().toUtc();
    final done = await runGuarded(
      context,
      () => ref.read(grapeVarietyRepositoryProvider).save(
            GrapeVariety(
              id: variety.id,
              code: variety.code,
              name: variety.name,
              category: variety.category,
              description: variety.description,
              aliases: variety.aliases,
              active: !variety.active,
              createdAt: variety.createdAt,
              updatedAt: now,
            ),
          ),
    );
    if (done && context.mounted) {
      showMessage(
        context,
        variety.active
            ? 'La variedad quedó inactiva y conserva su historial.'
            : 'La variedad volvió a estar disponible.',
      );
    }
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final confirmed = await confirmAction(
      context,
      title: 'Eliminar variedad',
      message: 'Solo se elimina si no está asociada a ninguna parcela. Si '
          'tiene historial, desactívala para conservarlo.',
      confirmLabel: 'Eliminar',
      destructive: true,
    );
    if (!confirmed || !context.mounted) return;
    final done = await runGuarded(
      context,
      () => ref.read(grapeVarietyRepositoryProvider).delete(variety.id),
    );
    if (done && context.mounted) {
      showMessage(context, 'Variedad eliminada.');
    }
  }
}

class _VarietyFormDialog extends ConsumerStatefulWidget {
  const _VarietyFormDialog({this.variety});

  final GrapeVariety? variety;

  @override
  ConsumerState<_VarietyFormDialog> createState() =>
      _VarietyFormDialogState();
}

class _VarietyFormDialogState extends ConsumerState<_VarietyFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _code;
  late final TextEditingController _name;
  late final TextEditingController _category;
  late final TextEditingController _aliases;
  late final TextEditingController _description;
  late bool _active;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final variety = widget.variety;
    _code = TextEditingController(text: variety?.code ?? '');
    _name = TextEditingController(text: variety?.name ?? '');
    _category = TextEditingController(
      text: (variety?.category == 'Tinta') ? 'Tinta' : 'Blanca',
    );
    _aliases = TextEditingController(text: variety?.aliases ?? '');
    _description = TextEditingController(text: variety?.description ?? '');
    _active = variety?.active ?? true;
    if (variety == null) _loadNextCode();
  }

  Future<void> _loadNextCode() async {
    final code = await ref.read(grapeVarietyRepositoryProvider).nextCode();
    if (mounted && _code.text.isEmpty) {
      setState(() => _code.text = code);
    }
  }

  @override
  void dispose() {
    _code.dispose();
    _name.dispose();
    _category.dispose();
    _aliases.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    final now = DateTime.now().toUtc();
    final existing = widget.variety;
    final variety = GrapeVariety(
      id: existing?.id ?? const Uuid().v4(),
      code: _code.text.trim(),
      name: _name.text.trim(),
      category: _category.text,
      description: _description.text,
      aliases: _aliases.text,
      active: _active,
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );
    final done = await runGuarded(
      context,
      () => ref.read(grapeVarietyRepositoryProvider).save(variety),
    );
    if (!mounted) return;
    setState(() => _saving = false);
    if (done) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.variety == null ? 'Nueva variedad' : 'Editar variedad'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _code,
                readOnly: true,
                canRequestFocus: false,
                decoration: const InputDecoration(
                  labelText: 'Código',
                  helperText: 'COD · asignado por el sistema',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(labelText: 'Nombre'),
                textCapitalization: TextCapitalization.words,
                validator: (value) => Validators.requiredText(
                  value,
                  message: 'Ingresa el nombre de la variedad.',
                  maxLength: 80,
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: (_category.text == 'Blanca' || _category.text == 'Tinta')
                    ? _category.text
                    : 'Blanca',
                decoration: const InputDecoration(
                  labelText: 'Categoría *',
                  helperText: 'Solo se permiten: Blanca o Tinta',
                ),
                items: const [
                  DropdownMenuItem(value: 'Blanca', child: Text('Blanca')),
                  DropdownMenuItem(value: 'Tinta', child: Text('Tinta')),
                ],
                onChanged: (val) {
                  if (val != null) {
                    setState(() => _category.text = val);
                  }
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _aliases,
                decoration: const InputDecoration(
                  labelText: 'Alias',
                  helperText: 'Nombres alternativos separados por comas',
                ),
                validator: (value) =>
                    Validators.optionalText(value, maxLength: 160),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _description,
                decoration: const InputDecoration(labelText: 'Descripción'),
                maxLines: 3,
                validator: (value) =>
                    Validators.optionalText(value, maxLength: 500),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Disponible para nuevos registros'),
                value: _active,
                onChanged: (value) => setState(() => _active = value),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: Text(_saving ? 'Guardando…' : 'Guardar'),
        ),
      ],
    );
  }
}
