import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/formatting/formatters.dart';
import '../../../core/validation/validators.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/feedback.dart';
import '../../../core/widgets/section_card.dart';
import '../data/production_providers.dart';
import '../domain/entities/harvest_season.dart';
import '../domain/entities/measurement_unit.dart';

/// Administración de temporadas agrícolas y unidades de registro.
///
/// Las estimaciones se registran desde el detalle de cada parcela para no
/// perder el contexto de la superficie y las variedades asociadas.
class ProductionPage extends StatelessWidget {
  const ProductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Producción'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Temporadas'),
              Tab(text: 'Unidades'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _SeasonsTab(),
            _UnitsTab(),
          ],
        ),
      ),
    );
  }
}

class _SeasonsTab extends ConsumerWidget {
  const _SeasonsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seasons = ref.watch(harvestSeasonsProvider);
    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: [
        SectionCard(
          title: 'Temporadas agrícolas',
          icon: Icons.event_note_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Las estimaciones se conservan por temporada. Crear una nueva '
                'no sobrescribe las anteriores.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => _openForm(context),
                icon: const Icon(Icons.add),
                label: const Text('Nueva temporada'),
              ),
            ],
          ),
        ),
        AsyncValueView<List<HarvestSeason>>(
          value: seasons,
          isEmpty: (data) => data.isEmpty,
          emptyMessage: 'Todavía no hay temporadas registradas.',
          onRetry: () => ref.invalidate(harvestSeasonsProvider),
          builder: (data) => Column(
            children: [
              for (final season in data)
                _SeasonTile(season: season, onEdit: () => _openForm(context, season)),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _openForm(
    BuildContext context, [
    HarvestSeason? season,
  ]) async {
    await showDialog<void>(
      context: context,
      builder: (_) => _SeasonFormDialog(season: season),
    );
  }
}

class _SeasonTile extends ConsumerWidget {
  const _SeasonTile({required this.season, required this.onEdit});

  final HarvestSeason season;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final range = _range(season);
    final notes = season.notes;
    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.event_outlined)),
        title: Text(season.name),
        subtitle: range == null && (notes == null || notes.isEmpty)
            ? null
            : Text(
                [
                  if (range != null) range,
                  if (notes != null && notes.isNotEmpty) notes,
                ].join('\n'),
              ),
        isThreeLine: range != null && notes != null && notes.isNotEmpty,
        onTap: onEdit,
        trailing: PopupMenuButton<String>(
          tooltip: 'Acciones',
          onSelected: (value) async {
            switch (value) {
              case 'edit':
                onEdit();
              case 'delete':
                await _delete(context, ref);
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'edit', child: Text('Editar')),
            PopupMenuItem(value: 'delete', child: Text('Eliminar')),
          ],
        ),
      ),
    );
  }

  static String? _range(HarvestSeason season) {
    final start = season.startDate;
    final end = season.endDate;
    if (start == null && end == null) return null;
    if (start != null && end != null) {
      return '${Formatters.date(start)} – ${Formatters.date(end)}';
    }
    if (start != null) return 'Desde ${Formatters.date(start)}';
    return 'Hasta ${Formatters.date(end)}';
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final confirmed = await confirmAction(
      context,
      title: 'Eliminar temporada',
      message: 'Solo se elimina si no tiene estimaciones registradas. El '
          'historial de producción se conserva siempre.',
      confirmLabel: 'Eliminar',
      destructive: true,
    );
    if (!confirmed || !context.mounted) return;
    final done = await runGuarded(
      context,
      () => ref.read(harvestSeasonRepositoryProvider).delete(season.id),
    );
    if (done && context.mounted) {
      showMessage(context, 'Temporada eliminada.');
    }
  }
}

class _SeasonFormDialog extends ConsumerStatefulWidget {
  const _SeasonFormDialog({this.season});

  final HarvestSeason? season;

  @override
  ConsumerState<_SeasonFormDialog> createState() => _SeasonFormDialogState();
}

class _SeasonFormDialogState extends ConsumerState<_SeasonFormDialog> {
  late final TextEditingController _name;
  late final TextEditingController _notes;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final season = widget.season;
    _name = TextEditingController(text: season?.name ?? '');
    _notes = TextEditingController(text: season?.notes ?? '');
    _startDate = season?.startDate?.toLocal();
    _endDate = season?.endDate?.toLocal();
  }

  @override
  void dispose() {
    _name.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool start}) async {
    final initial = start
        ? (_startDate ?? _endDate ?? DateTime.now())
        : (_endDate ?? _startDate ?? DateTime.now());
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
      helpText: start ? 'Inicio de la temporada' : 'Fin de la temporada',
    );
    if (picked == null || !mounted) return;
    setState(() {
      if (start) {
        _startDate = picked;
      } else {
        _endDate = picked;
      }
    });
  }

  Future<void> _save() async {
    if (!(_name.text.trim().isNotEmpty)) {
      showMessage(context, 'Ingresa el nombre de la temporada.');
      return;
    }
    final start = _startDate;
    final end = _endDate;
    if (start != null && end != null && start.isAfter(end)) {
      showMessage(
        context,
        'La fecha de inicio no puede ser posterior a la de fin.',
      );
      return;
    }
    setState(() => _saving = true);
    final now = DateTime.now().toUtc();
    final existing = widget.season;
    final season = HarvestSeason(
      id: existing?.id ?? const Uuid().v4(),
      name: _name.text.trim(),
      startDate: start,
      endDate: end,
      notes: _notes.text,
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );
    final done = await runGuarded(
      context,
      () => ref.read(harvestSeasonRepositoryProvider).save(season),
    );
    if (!mounted) return;
    setState(() => _saving = false);
    if (done) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.season == null ? 'Nueva temporada' : 'Editar temporada',
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _name,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                helperText: 'Por ejemplo 2026 o 2026-2027',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 12),
            _DateField(
              label: 'Inicio',
              value: _startDate,
              onTap: () => _pickDate(start: true),
              onClear: () => setState(() => _startDate = null),
            ),
            const SizedBox(height: 12),
            _DateField(
              label: 'Fin',
              value: _endDate,
              onTap: () => _pickDate(start: false),
              onClear: () => setState(() => _endDate = null),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _notes,
              decoration: const InputDecoration(labelText: 'Observaciones'),
              maxLines: 2,
            ),
          ],
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

class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.value,
    required this.onTap,
    required this.onClear,
  });

  final String label;
  final DateTime? value;
  final VoidCallback onTap;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: value == null
              ? const Icon(Icons.calendar_today_outlined)
              : IconButton(
                  tooltip: 'Quitar fecha',
                  icon: const Icon(Icons.clear),
                  onPressed: onClear,
                ),
        ),
        child: Text(value == null ? 'Sin fecha' : Formatters.date(value)),
      ),
    );
  }
}

class _UnitsTab extends ConsumerWidget {
  const _UnitsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final units = ref.watch(measurementUnitsProvider(true));
    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: [
        SectionCard(
          title: 'Unidades de registro',
          icon: Icons.straighten_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'El factor de conversión se guarda en cada estimación. Cambiar '
                'una unidad aquí no altera los cálculos históricos.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => _openForm(context),
                icon: const Icon(Icons.add),
                label: const Text('Nueva unidad'),
              ),
            ],
          ),
        ),
        AsyncValueView<List<MeasurementUnit>>(
          value: units,
          isEmpty: (data) => data.isEmpty,
          emptyMessage: 'Todavía no hay unidades registradas.',
          onRetry: () => ref.invalidate(measurementUnitsProvider(true)),
          builder: (data) => Column(
            children: [
              for (final unit in data)
                _UnitTile(unit: unit, onEdit: () => _openForm(context, unit)),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _openForm(
    BuildContext context, [
    MeasurementUnit? unit,
  ]) async {
    await showDialog<void>(
      context: context,
      builder: (_) => _UnitFormDialog(unit: unit),
    );
  }
}

class _UnitTile extends ConsumerWidget {
  const _UnitTile({required this.unit, required this.onEdit});

  final MeasurementUnit unit;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final factor = unit.kilogramsEquivalent;
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(
            unit.active ? Icons.straighten_outlined : Icons.straighten,
            color: unit.active
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline,
          ),
        ),
        title: Row(
          children: [
            Flexible(child: Text(unit.name)),
            const SizedBox(width: 8),
            Chip(
              label: Text(unit.code),
              visualDensity: VisualDensity.compact,
            ),
            if (!unit.active) ...[
              const SizedBox(width: 8),
              const Chip(
                label: Text('Inactiva'),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ],
        ),
        subtitle: Text(
          factor == null
              ? 'Factor configurable en cada estimación'
              : '1 ${unit.code} = ${Formatters.decimal(factor)} kg',
        ),
        onTap: onEdit,
        trailing: PopupMenuButton<String>(
          tooltip: 'Acciones',
          onSelected: (value) async {
            switch (value) {
              case 'edit':
                onEdit();
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
              child: Text(unit.active ? 'Desactivar' : 'Activar'),
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
      () => ref.read(measurementUnitRepositoryProvider).save(
            MeasurementUnit(
              id: unit.id,
              code: unit.code,
              name: unit.name,
              kilogramsEquivalent: unit.kilogramsEquivalent,
              active: !unit.active,
              createdAt: unit.createdAt,
              updatedAt: now,
            ),
          ),
    );
    if (done && context.mounted) {
      showMessage(
        context,
        unit.active
            ? 'La unidad quedó inactiva y conserva su historial.'
            : 'La unidad volvió a estar disponible.',
      );
    }
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final confirmed = await confirmAction(
      context,
      title: 'Eliminar unidad',
      message: 'Solo se elimina si no tiene estimaciones registradas. Si las '
          'tiene, desactívala para conservar el historial.',
      confirmLabel: 'Eliminar',
      destructive: true,
    );
    if (!confirmed || !context.mounted) return;
    final done = await runGuarded(
      context,
      () => ref.read(measurementUnitRepositoryProvider).delete(unit.id),
    );
    if (done && context.mounted) {
      showMessage(context, 'Unidad eliminada.');
    }
  }
}

class _UnitFormDialog extends ConsumerStatefulWidget {
  const _UnitFormDialog({this.unit});

  final MeasurementUnit? unit;

  @override
  ConsumerState<_UnitFormDialog> createState() => _UnitFormDialogState();
}

class _UnitFormDialogState extends ConsumerState<_UnitFormDialog> {
  late final TextEditingController _code;
  late final TextEditingController _name;
  late final TextEditingController _factor;
  late bool _active;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final unit = widget.unit;
    _code = TextEditingController(text: unit?.code ?? '');
    _name = TextEditingController(text: unit?.name ?? '');
    _factor = TextEditingController(
      text: unit?.kilogramsEquivalent == null
          ? ''
          : Formatters.quantity(unit!.kilogramsEquivalent),
    );
    _active = unit?.active ?? true;
  }

  @override
  void dispose() {
    _code.dispose();
    _name.dispose();
    _factor.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final codeError = Validators.requiredCode(
      _code.text,
      message: 'Ingresa el código de la unidad.',
      maxLength: 16,
    );
    if (codeError != null) {
      showMessage(context, codeError);
      return;
    }
    final nameError = Validators.requiredText(
      _name.text,
      message: 'Ingresa el nombre de la unidad.',
      maxLength: 60,
    );
    if (nameError != null) {
      showMessage(context, nameError);
      return;
    }
    final rawFactor = _factor.text.trim();
    if (rawFactor.isNotEmpty) {
      final error = Validators.positiveDecimal(
        rawFactor,
        message: 'La equivalencia en kilogramos debe ser mayor a cero.',
      );
      if (error != null) {
        showMessage(context, error);
        return;
      }
    }
    setState(() => _saving = true);
    final now = DateTime.now().toUtc();
    final existing = widget.unit;
    final unit = MeasurementUnit(
      id: existing?.id ?? const Uuid().v4(),
      code: _code.text.trim(),
      name: _name.text.trim(),
      kilogramsEquivalent:
          rawFactor.isEmpty ? null : Validators.parsePlainDecimal(rawFactor),
      active: _active,
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );
    final done = await runGuarded(
      context,
      () => ref.read(measurementUnitRepositoryProvider).save(unit),
    );
    if (!mounted) return;
    setState(() => _saving = false);
    if (done) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.unit == null ? 'Nueva unidad' : 'Editar unidad'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _code,
              decoration: const InputDecoration(
                labelText: 'Código',
                helperText: 'Único y corto, por ejemplo kg, crate o ton',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Nombre visible'),
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _factor,
              decoration: const InputDecoration(
                labelText: 'Equivalencia en kg',
                helperText: 'Opcional; déjala vacía si varía por estimación',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
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
