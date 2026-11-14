import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/formatting/formatters.dart';
import '../../../../core/validation/validators.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/feedback.dart';
import '../../../../core/widgets/section_card.dart';
import '../../data/grape_variety_providers.dart';
import '../../domain/entities/grape_variety.dart';
import '../../domain/entities/parcel_variety.dart';

/// Distribución de variedades de una parcela.
///
/// Se integra en el detalle de parcela y muestra la composición, los
/// porcentajes informados y la superficie aproximada de cada variedad.
class VarietyDistributionSection extends ConsumerWidget {
  const VarietyDistributionSection({
    required this.parcelId,
    this.parcelAreaM2,
    super.key,
  });

  final String parcelId;
  final double? parcelAreaM2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final links = ref.watch(parcelVarietiesProvider(parcelId));
    final catalogue = ref.watch(
      grapeVarietiesProvider(const VarietyFilter(includeInactive: true)),
    );
    final varietiesById = {
      for (final variety in catalogue.valueOrNull ?? const <GrapeVariety>[])
        variety.id: variety,
    };
    return SectionCard(
      title: 'Variedades',
      icon: Icons.eco_outlined,
      trailing: TextButton.icon(
        onPressed: () => _add(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Agregar'),
      ),
      child: AsyncValueView<List<ParcelVariety>>(
        value: links,
        isEmpty: (data) => data.isEmpty,
        emptyMessage: 'Sin variedades asociadas a esta parcela.',
        onRetry: () => ref.invalidate(parcelVarietiesProvider(parcelId)),
        builder: (data) => _DistributionBody(
          parcelId: parcelId,
          parcelAreaM2: parcelAreaM2,
          links: data,
          varietiesById: varietiesById,
        ),
      ),
    );
  }

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final repository = ref.read(parcelVarietyRepositoryProvider);
    final catalogueRepository = ref.read(grapeVarietyRepositoryProvider);
    final links = await repository.findByParcel(parcelId);
    final catalogue = await catalogueRepository.findAll();
    final linkedIds = links.map((link) => link.grapeVarietyId).toSet();
    final available = catalogue
        .where((variety) => variety.active && !linkedIds.contains(variety.id))
        .toList();
    if (!context.mounted) return;
    if (available.isEmpty) {
      showMessage(
        context,
        catalogue.isEmpty
            ? 'El catálogo está vacío. Registra una variedad primero.'
            : 'No hay variedades activas disponibles para asociar.',
      );
      return;
    }
    await showDialog<void>(
      context: context,
      builder: (_) => _ParcelVarietyDialog(
        parcelId: parcelId,
        varieties: available,
        otherPercentages: links
            .map((link) => link.plantedAreaPercentage)
            .whereType<double>()
            .toList(),
      ),
    );
  }
}

class _DistributionBody extends ConsumerWidget {
  const _DistributionBody({
    required this.parcelId,
    required this.parcelAreaM2,
    required this.links,
    required this.varietiesById,
  });

  final String parcelId;
  final double? parcelAreaM2;
  final List<ParcelVariety> links;
  final Map<String, GrapeVariety> varietiesById;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final informed = links
        .map((link) => link.plantedAreaPercentage)
        .whereType<double>()
        .toList();
    final sum = informed.fold<double>(0, (total, value) => total + value);
    final shouldWarn = informed.isNotEmpty && (sum - 100).abs() > 0.01;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final link in links)
          _VarietyLinkTile(
            parcelId: parcelId,
            parcelAreaM2: parcelAreaM2,
            link: link,
            variety: varietiesById[link.grapeVarietyId],
            otherPercentages: links
                .where((other) => other.id != link.id)
                .map((other) => other.plantedAreaPercentage)
                .whereType<double>()
                .toList(),
            allVarieties: varietiesById.values.toList(),
          ),
        if (informed.isNotEmpty) ...[
          const Divider(),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Total informado',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Text(
                '${Formatters.percent(sum)}'
                '${parcelAreaM2 == null ? '' : ' · ${_area(sum)}'}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ],
        if (shouldWarn) ...[
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 20,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'La suma de porcentajes es ${Formatters.percent(sum)}. Se '
                  'advierte, pero se conserva tal como fue registrada.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ],
        const SizedBox(height: 8),
        Text(
          'Los porcentajes representan superficie cultivada, no proporción de '
          'producción.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  String _area(double percentage) =>
      Formatters.area((parcelAreaM2 ?? 0) * percentage / 100);
}

class _VarietyLinkTile extends ConsumerWidget {
  const _VarietyLinkTile({
    required this.parcelId,
    required this.parcelAreaM2,
    required this.link,
    required this.variety,
    required this.otherPercentages,
    required this.allVarieties,
  });

  final String parcelId;
  final double? parcelAreaM2;
  final ParcelVariety link;
  final GrapeVariety? variety;
  final List<double> otherPercentages;
  final List<GrapeVariety> allVarieties;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final percentage = link.plantedAreaPercentage;
    final area = percentage == null || parcelAreaM2 == null
        ? null
        : parcelAreaM2! * percentage / 100;
    final notes = link.notes;
    final subtitle = [
      percentage == null ? 'Superficie no informada' : _surface(percentage, area),
      if (notes != null && notes.isNotEmpty) notes,
    ].join('\n');
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.eco_outlined),
      title: Row(
        children: [
          Flexible(child: Text(variety?.name ?? 'Variedad')),
          if (variety != null && !variety!.active) ...[
            const SizedBox(width: 8),
            const Chip(
              label: Text('Inactiva'),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ],
      ),
      subtitle: Text(subtitle),
      isThreeLine: notes != null && notes.isNotEmpty,
      onTap: () => _edit(context, ref),
      trailing: IconButton(
        tooltip: 'Quitar variedad',
        icon: const Icon(Icons.link_off),
        onPressed: () => _remove(context, ref),
      ),
    );
  }

  String _surface(double percentage, double? area) {
    final percent = Formatters.percent(percentage);
    return area == null
        ? 'Superficie $percent'
        : 'Superficie $percent · ${Formatters.area(area)}';
  }

  Future<void> _edit(BuildContext context, WidgetRef ref) async {
    await showDialog<void>(
      context: context,
      builder: (_) => _ParcelVarietyDialog(
        parcelId: parcelId,
        existing: link,
        varieties: allVarieties,
        otherPercentages: otherPercentages,
      ),
    );
  }

  Future<void> _remove(BuildContext context, WidgetRef ref) async {
    final confirmed = await confirmAction(
      context,
      title: 'Quitar variedad',
      message: 'Solo se quita la asociación de esta variedad con la parcela; '
          'el catálogo y la parcela se conservan.',
      confirmLabel: 'Quitar',
      destructive: true,
    );
    if (!confirmed || !context.mounted) return;
    final done = await runGuarded(
      context,
      () => ref.read(parcelVarietyRepositoryProvider).delete(link.id),
    );
    if (done && context.mounted) {
      showMessage(context, 'Variedad quitada de la parcela.');
    }
  }
}

class _ParcelVarietyDialog extends ConsumerStatefulWidget {
  const _ParcelVarietyDialog({
    required this.parcelId,
    required this.varieties,
    required this.otherPercentages,
    this.existing,
  });

  final String parcelId;
  final List<GrapeVariety> varieties;
  final List<double> otherPercentages;
  final ParcelVariety? existing;

  @override
  ConsumerState<_ParcelVarietyDialog> createState() =>
      _ParcelVarietyDialogState();
}

class _ParcelVarietyDialogState extends ConsumerState<_ParcelVarietyDialog> {
  late final TextEditingController _percentage;
  late final TextEditingController _notes;
  late String? _varietyId;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _varietyId = existing?.grapeVarietyId;
    _percentage = TextEditingController(
      text: existing?.plantedAreaPercentage == null
          ? ''
          : Formatters.quantity(existing!.plantedAreaPercentage),
    );
    _notes = TextEditingController(text: existing?.notes ?? '');
  }

  @override
  void dispose() {
    _percentage.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final varietyId = _varietyId;
    if (varietyId == null) {
      showMessage(context, 'Selecciona una variedad.');
      return;
    }
    final raw = _percentage.text.trim();
    final error = Validators.percentage(raw);
    if (error != null) {
      showMessage(context, error);
      return;
    }
    final percentage = Validators.parsePlainDecimal(raw);
    if (percentage != null) {
      final total = [
        ...widget.otherPercentages,
        percentage,
      ].fold<double>(0, (sum, value) => sum + value);
      if ((total - 100).abs() > 0.01) {
        final proceed = await confirmAction(
          context,
          title: 'Distribución distinta de 100 %',
          message: 'La suma de porcentajes informados quedaría en '
              '${Formatters.percent(total)}. ¿Deseas continuar?',
          confirmLabel: 'Continuar',
        );
        if (!proceed || !mounted) return;
      }
    }
    setState(() => _saving = true);
    final now = DateTime.now().toUtc();
    final existing = widget.existing;
    final link = ParcelVariety(
      id: existing?.id ?? const Uuid().v4(),
      parcelId: widget.parcelId,
      grapeVarietyId: varietyId,
      plantedAreaPercentage: percentage,
      notes: _notes.text,
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );
    final done = await runGuarded(
      context,
      () => ref.read(parcelVarietyRepositoryProvider).save(link),
    );
    if (!mounted) return;
    setState(() => _saving = false);
    if (done) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.existing == null ? 'Asociar variedad' : 'Editar variedad',
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              initialValue: _varietyId,
              decoration: const InputDecoration(labelText: 'Variedad'),
              items: [
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
              onChanged: (value) => setState(() => _varietyId = value),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _percentage,
              decoration: const InputDecoration(
                labelText: 'Superficie de la parcela (%)',
                helperText: 'Opcional, entre 0 y 100',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
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
