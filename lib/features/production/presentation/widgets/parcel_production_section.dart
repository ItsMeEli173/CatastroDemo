import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/formatting/formatters.dart';
import '../../../../core/validation/validators.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/feedback.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../grape_varieties/data/grape_variety_providers.dart';
import '../../../grape_varieties/domain/entities/grape_variety.dart';
import '../../../grape_varieties/domain/entities/parcel_variety.dart';
import '../../data/production_providers.dart';
import '../../domain/entities/harvest_season.dart';
import '../../domain/entities/measurement_unit.dart';
import '../../domain/entities/production_estimate.dart';
import '../../domain/services/production_math.dart';

/// Estimaciones de producción de una parcela.
///
/// Se integra en el detalle de parcela y distingue estimaciones generales de
/// las que corresponden a una variedad concreta.
class ParcelProductionSection extends ConsumerWidget {
  const ParcelProductionSection({required this.parcelId, super.key});

  final String parcelId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estimates = ref.watch(
      productionEstimatesProvider(EstimateFilter(parcelId: parcelId)),
    );
    final seasons = ref.watch(harvestSeasonsProvider);
    final units = ref.watch(measurementUnitsProvider(true));
    final links = ref.watch(parcelVarietiesProvider(parcelId));
    final catalogue = ref.watch(
      grapeVarietiesProvider(const VarietyFilter(includeInactive: true)),
    );
    return SectionCard(
      title: 'Producción estimada',
      icon: Icons.scale_outlined,
      trailing: TextButton.icon(
        onPressed: () => _add(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Registrar'),
      ),
      child: AsyncValueView<List<ProductionEstimate>>(
        value: estimates,
        isEmpty: (data) => data.isEmpty,
        emptyMessage: 'Sin estimaciones registradas.',
        onRetry: () => ref.invalidate(
          productionEstimatesProvider(EstimateFilter(parcelId: parcelId)),
        ),
        builder: (data) => _EstimatesBody(
          estimates: data,
          seasonsById: {
            for (final season in seasons.asData?.value ?? const <HarvestSeason>[])
              season.id: season,
          },
          unitsById: {
            for (final unit in units.asData?.value ?? const <MeasurementUnit>[])
              unit.id: unit,
          },
          varietiesById: {
            for (final variety
                in catalogue.asData?.value ?? const <GrapeVariety>[])
              variety.id: variety,
          },
          links: links.asData?.value ?? const <ParcelVariety>[],
        ),
      ),
    );
  }

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final seasons =
        await ref.read(harvestSeasonRepositoryProvider).findAll();
    final units = await ref
        .read(measurementUnitRepositoryProvider)
        .findAll(includeInactive: false);
    final links =
        await ref.read(parcelVarietyRepositoryProvider).findByParcel(parcelId);
    final catalogue = await ref.read(grapeVarietyRepositoryProvider).findAll();
    final linkedIds = links.map((link) => link.grapeVarietyId).toSet();
    final varieties = catalogue
        .where((variety) => variety.active || linkedIds.contains(variety.id))
        .toList();
    if (!context.mounted) return;
    if (seasons.isEmpty) {
      showMessage(
        context,
        'Primero crea una temporada agrícola en el módulo Producción.',
      );
      return;
    }
    if (units.isEmpty) {
      showMessage(
        context,
        'Primero configura una unidad de registro en el módulo Producción.',
      );
      return;
    }
    await showDialog<void>(
      context: context,
      builder: (_) => _EstimateDialog(
        parcelId: parcelId,
        seasons: seasons,
        units: units,
        varieties: varieties,
      ),
    );
  }
}

class _EstimatesBody extends StatelessWidget {
  const _EstimatesBody({
    required this.estimates,
    required this.seasonsById,
    required this.unitsById,
    required this.varietiesById,
    required this.links,
  });

  final List<ProductionEstimate> estimates;
  final Map<String, HarvestSeason> seasonsById;
  final Map<String, MeasurementUnit> unitsById;
  final Map<String, GrapeVariety> varietiesById;
  final List<ParcelVariety> links;

  @override
  Widget build(BuildContext context) {
    final groups = <String, List<ProductionEstimate>>{};
    for (final estimate in estimates) {
      groups.putIfAbsent(estimate.seasonId, () => []).add(estimate);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final entry in groups.entries)
          _SeasonGroup(
            season: seasonsById[entry.key],
            estimates: entry.value,
            unitsById: unitsById,
            varietiesById: varietiesById,
          ),
        const Divider(),
        Text(
          'Las estimaciones generales y los desgloses por variedad se '
          'muestran por separado y nunca se suman entre sí, para evitar '
          'duplicar la producción.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _SeasonGroup extends StatelessWidget {
  const _SeasonGroup({
    required this.season,
    required this.estimates,
    required this.unitsById,
    required this.varietiesById,
  });

  final HarvestSeason? season;
  final List<ProductionEstimate> estimates;
  final Map<String, MeasurementUnit> unitsById;
  final Map<String, GrapeVariety> varietiesById;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final general = estimates.where((estimate) => estimate.isGeneral).toList();
    final byVariety =
        estimates.where((estimate) => !estimate.isGeneral).toList();
    final generalKg = general.fold<double>(
      0,
      (total, estimate) => total + estimate.estimatedKg,
    );
    final varietyKg = byVariety.fold<double>(
      0,
      (total, estimate) => total + estimate.estimatedKg,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 4),
          child: Row(
            children: [
              Icon(
                Icons.event_outlined,
                size: 18,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  season?.name ?? 'Temporada',
                  style: theme.textTheme.titleSmall,
                ),
              ),
            ],
          ),
        ),
        for (final estimate in general)
          _EstimateTile(
            estimate: estimate,
            unit: unitsById[estimate.unitId],
            variety: null,
          ),
        if (general.isNotEmpty)
          _TotalRow(
            label: 'Total general',
            kilograms: generalKg,
          ),
        if (byVariety.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            'Desglose por variedad',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
          for (final estimate in byVariety)
            _EstimateTile(
              estimate: estimate,
              unit: unitsById[estimate.unitId],
              variety: varietiesById[estimate.grapeVarietyId],
            ),
          _TotalRow(
            label: 'Total por variedad',
            kilograms: varietyKg,
          ),
        ],
        const SizedBox(height: 8),
      ],
    );
  }
}

class _TotalRow extends StatelessWidget {
  const _TotalRow({
    required this.label,
    required this.kilograms,
  });

  final String label;
  final double kilograms;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(child: Text(label, style: theme.textTheme.bodyMedium)),
          Text(
            Formatters.kilograms(kilograms),
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _EstimateTile extends ConsumerWidget {
  const _EstimateTile({
    required this.estimate,
    required this.unit,
    required this.variety,
  });

  final ProductionEstimate estimate;
  final MeasurementUnit? unit;
  final GrapeVariety? variety;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unitCode = unit?.displayAbbreviation ?? 'unidad';
    final notes = estimate.notes;
    final subtitle = [
      variety == null
          ? 'Estimación general de la parcela'
          : 'Variedad: ${variety!.name}',
      'Factor aplicado: ${Formatters.decimal(estimate.conversionFactorKg)} '
          'kg/$unitCode · ${Formatters.kilograms(estimate.estimatedKg)}',
      if (notes != null && notes.isNotEmpty) notes,
    ].join('\n');
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        variety == null ? Icons.landscape_outlined : Icons.eco_outlined,
      ),
      title: Text(
        '${Formatters.quantity(estimate.quantity)} $unitCode',
      ),
      subtitle: Text(subtitle),
      isThreeLine: notes != null && notes.isNotEmpty,
      trailing: IconButton(
        tooltip: 'Eliminar estimación',
        icon: const Icon(Icons.delete_outline),
        onPressed: () => _delete(context, ref),
      ),
    );
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final confirmed = await confirmAction(
      context,
      title: 'Eliminar estimación',
      message: 'Se elimina este registro de producción. Las demás temporadas y '
          'estimaciones se conservan.',
      confirmLabel: 'Eliminar',
      destructive: true,
    );
    if (!confirmed || !context.mounted) return;
    final done = await runGuarded(
      context,
      () => ref.read(productionEstimateRepositoryProvider).delete(estimate.id),
    );
    if (done && context.mounted) {
      showMessage(context, 'Estimación eliminada.');
    }
  }
}

class _EstimateDialog extends ConsumerStatefulWidget {
  const _EstimateDialog({
    required this.parcelId,
    required this.seasons,
    required this.units,
    required this.varieties,
  });

  final String parcelId;
  final List<HarvestSeason> seasons;
  final List<MeasurementUnit> units;
  final List<GrapeVariety> varieties;

  @override
  ConsumerState<_EstimateDialog> createState() => _EstimateDialogState();
}

class _EstimateDialogState extends ConsumerState<_EstimateDialog> {
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _factor = TextEditingController();
  final TextEditingController _notes = TextEditingController();
  String? _seasonId;
  String _varietyId = '';
  String? _unitId;
  bool _saving = false;

  @override
  void dispose() {
    _quantity.dispose();
    _factor.dispose();
    _notes.dispose();
    super.dispose();
  }

  MeasurementUnit? get _selectedUnit {
    final id = _unitId;
    if (id == null) return null;
    for (final unit in widget.units) {
      if (unit.id == id) return unit;
    }
    return null;
  }

  double? get _previewKg {
    final quantity = Validators.parsePlainDecimal(_quantity.text);
    final factor = Validators.parsePlainDecimal(_factor.text);
    if (quantity == null || factor == null || quantity <= 0 || factor <= 0) {
      return null;
    }
    return quantity * factor;
  }

  Future<void> _save() async {
    final seasonId = _seasonId;
    if (seasonId == null) {
      showMessage(context, 'Selecciona una temporada.');
      return;
    }
    final unitId = _unitId;
    if (unitId == null) {
      showMessage(context, 'Selecciona una unidad de registro.');
      return;
    }
    final quantityError = Validators.positiveDecimal(
      _quantity.text,
      message: 'Ingresa una cantidad mayor a cero.',
    );
    if (quantityError != null) {
      showMessage(context, quantityError);
      return;
    }
    final factorError = Validators.positiveDecimal(
      _factor.text,
      message: 'El factor de conversión debe ser mayor a cero.',
    );
    if (factorError != null) {
      showMessage(context, factorError);
      return;
    }
    final quantity = Validators.parsePlainDecimal(_quantity.text)!;
    final factor = Validators.parsePlainDecimal(_factor.text)!;
    final now = DateTime.now().toUtc();
    final estimate = ProductionEstimate(
      id: const Uuid().v4(),
      parcelId: widget.parcelId,
      seasonId: seasonId,
      grapeVarietyId: _varietyId.isEmpty ? null : _varietyId,
      quantity: quantity,
      unitId: unitId,
      conversionFactorKg: factor,
      estimatedKg: ProductionMath.estimatedKg(
        quantity: quantity,
        conversionFactorKg: factor,
      ),
      notes: _notes.text,
      createdAt: now,
      updatedAt: now,
    );
    setState(() => _saving = true);
    final done = await runGuarded(
      context,
      () => ref.read(productionEstimateRepositoryProvider).save(estimate),
    );
    if (!mounted) return;
    setState(() => _saving = false);
    if (done) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final preview = _previewKg;
    final selectedUnit = _selectedUnit;
    return AlertDialog(
      title: const Text('Registrar estimación'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              initialValue: _seasonId,
              decoration: const InputDecoration(labelText: 'Temporada'),
              items: [
                for (final season in widget.seasons)
                  DropdownMenuItem(value: season.id, child: Text(season.name)),
              ],
              onChanged: (value) => setState(() => _seasonId = value),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _varietyId,
              decoration: const InputDecoration(
                labelText: 'Alcance',
                helperText: 'General o limitada a una variedad',
              ),
              items: [
                const DropdownMenuItem(
                  value: '',
                  child: Text('Toda la parcela (general)'),
                ),
                for (final variety in widget.varieties)
                  DropdownMenuItem(
                    value: variety.id,
                    child: Text(
                      variety.active
                          ? variety.name
                          : '${variety.name} (inactiva)',
                    ),
                  ),
              ],
              onChanged: (value) =>
                  setState(() => _varietyId = value ?? ''),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _unitId,
              decoration: const InputDecoration(labelText: 'Unidad'),
              items: [
                for (final unit in widget.units)
                  DropdownMenuItem(
                    value: unit.id,
                    child: Text('${unit.name} (${unit.displayAbbreviation})'),
                  ),
              ],
              onChanged: (value) {
                setState(() {
                  _unitId = value;
                  final factor = _selectedUnit?.kilogramsEquivalent;
                  if (factor != null) {
                    _factor.text = Formatters.plainNumber(factor);
                  }
                });
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _quantity,
              decoration: InputDecoration(
                labelText: 'Cantidad',
                helperText: selectedUnit == null
                    ? null
                    : 'En ${selectedUnit.displayAbbreviation}',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _factor,
              decoration: InputDecoration(
                labelText: 'Factor de conversión (kg por unidad)',
                helperText: selectedUnit?.kilogramsEquivalent == null
                    ? 'Requerido: el peso del cajón es configurable'
                    : 'Puedes ajustarlo; quedará guardado en la estimación',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (_) => setState(() {}),
            ),
            if (preview != null) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Equivalencia: ${Formatters.kilograms(preview)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
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
