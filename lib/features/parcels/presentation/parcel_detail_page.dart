import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/formatting/formatters.dart';
import '../../../core/navigation/app_routes.dart';
import '../../../core/validation/validators.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/feedback.dart';
import '../../../core/widgets/section_card.dart';
import '../../farmers/data/farmer_providers.dart';
import '../../farmers/domain/entities/farmer.dart';
import '../../grape_varieties/presentation/widgets/variety_distribution_section.dart';
import '../../parcel_owners/data/parcel_owner_providers.dart';
import '../../parcel_owners/domain/entities/parcel_owner.dart';
import '../../production/presentation/widgets/parcel_production_section.dart';
import '../data/parcel_providers.dart';
import '../domain/entities/parcel.dart';
import '../domain/entities/parcel_vertex.dart';

/// Detalle completo de una parcela con sus secciones relacionadas.
class ParcelDetailPage extends ConsumerWidget {
  const ParcelDetailPage({required this.parcelId, super.key});

  final String parcelId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parcel = ref.watch(parcelProvider(parcelId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parcela'),
        actions: [
          IconButton(
            tooltip: 'Mapa',
            icon: const Icon(Icons.map_outlined),
            onPressed: () => AppRoutes.push<void>(
              context,
              AppRoutes.parcelMap,
              arguments: ParcelMapArgs(parcelId: parcelId),
            ),
          ),
          parcel.maybeWhen(
            data: (data) => data == null
                ? const SizedBox.shrink()
                : IconButton(
                    tooltip: 'Editar',
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () => AppRoutes.push<void>(
                      context,
                      AppRoutes.parcelForm,
                      arguments: ParcelFormArgs(parcelId: data.id),
                    ),
                  ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: AsyncValueView<Parcel?>(
        value: parcel,
        isEmpty: (data) => data == null,
        emptyMessage: 'La parcela no existe.',
        onRetry: () => ref.invalidate(parcelProvider(parcelId)),
        builder: (data) => _ParcelBody(parcel: data!),
      ),
    );
  }
}

class _ParcelBody extends ConsumerWidget {
  const _ParcelBody({required this.parcel});

  final Parcel parcel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vertices = ref.watch(parcelVerticesProvider(parcel.id));
    final vertexCount = vertices.maybeWhen(
      data: (data) => data.length,
      orElse: () => null,
    );
    final areaForDistribution = parcel.calculatedAreaM2 ?? parcel.declaredAreaM2;
    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: [
        SectionCard(
          title: parcel.displayName,
          icon: Icons.landscape_outlined,
          trailing: Chip(
            label: Text(parcel.status.label),
            visualDensity: VisualDensity.compact,
          ),
          child: Column(
            children: [
              DetailRow(label: 'Código', value: parcel.code),
              if (parcel.name != null && parcel.name!.isNotEmpty)
                DetailRow(label: 'Nombre', value: parcel.name!),
              if (parcel.notes != null && parcel.notes!.isNotEmpty)
                DetailRow(label: 'Observaciones', value: parcel.notes!),
              DetailRow(
                label: 'Registrada',
                value: Formatters.date(parcel.createdAt),
              ),
            ],
          ),
        ),
        SectionCard(
          title: 'Superficies',
          icon: Icons.square_foot_outlined,
          child: Column(
            children: [
              DetailRow(
                label: 'Calculada',
                value:
                    '${Formatters.area(parcel.calculatedAreaM2)} '
                    '(${Formatters.hectares(parcel.calculatedAreaM2)})',
              ),
              DetailRow(
                label: 'Declarada',
                value:
                    '${Formatters.area(parcel.declaredAreaM2)} '
                    '(${Formatters.hectares(parcel.declaredAreaM2)})',
              ),
              const SizedBox(height: 4),
              Text(
                'La superficie calculada es aproximada y se obtiene de los '
                'vértices; nunca reemplaza a la declarada.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        SectionCard(
          title: 'Geometría',
          icon: Icons.timeline_outlined,
          trailing: TextButton.icon(
            onPressed: () => AppRoutes.push<void>(
              context,
              AppRoutes.parcelVertices,
              arguments: ParcelVerticesArgs(parcelId: parcel.id),
            ),
            icon: const Icon(Icons.edit_location_alt_outlined),
            label: const Text('Vértices'),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailRow(
                label: 'Vértices',
                value: vertexCount == null ? '…' : '$vertexCount',
              ),
              const SizedBox(height: 4),
              Text(
                'Se necesitan al menos 3 vértices válidos para activar la '
                'parcela.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        _OwnersSection(parcel: parcel),
        VarietyDistributionSection(
          parcelId: parcel.id,
          parcelAreaM2: areaForDistribution,
        ),
        ParcelProductionSection(parcelId: parcel.id),
        _StatusActions(parcel: parcel),
      ],
    );
  }
}

class _OwnersSection extends ConsumerWidget {
  const _OwnersSection({required this.parcel});

  final Parcel parcel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final owners = ref.watch(parcelOwnersProvider(parcel.id));
    final farmers = ref.watch(farmersProvider(''));
    final farmersById = <String, Farmer>{
      for (final farmer in farmers.valueOrNull ?? const <Farmer>[])
        farmer.id: farmer,
    };
    return SectionCard(
      title: 'Propietarios',
      icon: Icons.group_outlined,
      trailing: TextButton.icon(
        onPressed: () => _addOwner(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Vincular'),
      ),
      child: AsyncValueView<List<ParcelOwner>>(
        value: owners,
        isEmpty: (data) => data.isEmpty,
        emptyMessage: 'Sin agricultores asociados a esta parcela.',
        onRetry: () => ref.invalidate(parcelOwnersProvider(parcel.id)),
        builder: (data) {
          final informed = data
              .map((owner) => owner.ownershipPercentage)
              .whereType<double>()
              .toList();
          final sum = informed.fold<double>(0, (total, value) => total + value);
          final shouldWarn = informed.isNotEmpty && (sum - 100).abs() > 0.01;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final owner in data)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.person_outline),
                  title: Text(
                    farmersById[owner.farmerId]?.fullName ?? 'Agricultor',
                  ),
                  subtitle: Text(
                    owner.ownershipPercentage == null
                        ? 'Participación no informada'
                        : 'Participación '
                            '${Formatters.percent(owner.ownershipPercentage)}',
                  ),
                  onTap: () => AppRoutes.push<void>(
                    context,
                    AppRoutes.farmerDetail,
                    arguments: FarmerDetailArgs(farmerId: owner.farmerId),
                  ),
                  trailing: IconButton(
                    tooltip: 'Quitar vínculo',
                    icon: const Icon(Icons.link_off),
                    onPressed: () async {
                      final confirmed = await confirmAction(
                        context,
                        title: 'Quitar vínculo',
                        message: 'Solo se quita la relación con este '
                            'agricultor; la parcela y el agricultor se '
                            'conservan.',
                        confirmLabel: 'Quitar',
                        destructive: true,
                      );
                      if (!confirmed) return;
                      await runGuarded(
                        context,
                        () => ref
                            .read(parcelOwnerRepositoryProvider)
                            .delete(owner.id),
                      );
                    },
                  ),
                ),
              if (shouldWarn)
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
                        'La suma de participaciones informadas es '
                        '${Formatters.percent(sum)}. Conviene revisarla, pero '
                        'se conserva tal como fue registrada.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _addOwner(BuildContext context, WidgetRef ref) async {
    final links = await ref
        .read(parcelOwnerRepositoryProvider)
        .findByParcel(parcel.id);
    final linkedIds = links.map((link) => link.farmerId).toSet();
    final all = await ref.read(farmerRepositoryProvider).findFarmers();
    final available =
        all.where((farmer) => !linkedIds.contains(farmer.id)).toList();
    if (!context.mounted) return;
    if (available.isEmpty) {
      showMessage(
        context,
        'No hay agricultores disponibles para vincular. Registra uno primero.',
      );
      return;
    }
    await showDialog<void>(
      context: context,
      builder: (_) => _AddOwnerDialog(
        parcel: parcel,
        farmers: available,
        informedPercentages: links
            .map((link) => link.ownershipPercentage)
            .whereType<double>()
            .toList(),
      ),
    );
  }
}

class _AddOwnerDialog extends ConsumerStatefulWidget {
  const _AddOwnerDialog({
    required this.parcel,
    required this.farmers,
    required this.informedPercentages,
  });

  final Parcel parcel;
  final List<Farmer> farmers;
  final List<double> informedPercentages;

  @override
  ConsumerState<_AddOwnerDialog> createState() => _AddOwnerDialogState();
}

class _AddOwnerDialogState extends ConsumerState<_AddOwnerDialog> {
  String? _farmerId;
  final TextEditingController _percentage = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _percentage.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final farmerId = _farmerId;
    if (farmerId == null) return;
    final raw = _percentage.text.trim();
    if (raw.isNotEmpty) {
      final error = Validators.percentage(raw, label: 'La participación');
      if (error != null) {
        showMessage(context, error);
        return;
      }
    }
    final percentage = raw.isEmpty ? null : Validators.parsePlainDecimal(raw);
    final informed = [
      ...widget.informedPercentages,
      if (percentage != null) percentage,
    ];
    final sum = informed.fold<double>(0, (total, value) => total + value);
    if (percentage != null && (sum - 100).abs() > 0.01) {
      final proceed = await confirmAction(
        context,
        title: 'Participación distinta de 100 %',
        message: 'La suma de participaciones informadas quedaría en '
            '${Formatters.percent(sum)}. ¿Deseas continuar?',
        confirmLabel: 'Continuar',
      );
      if (!proceed || !mounted) return;
    }
    setState(() => _saving = true);
    final now = DateTime.now().toUtc();
    final done = await runGuarded(
      context,
      () => ref.read(parcelOwnerRepositoryProvider).save(
            ParcelOwner(
              id: const Uuid().v4(),
              parcelId: widget.parcel.id,
              farmerId: farmerId,
              ownershipPercentage: percentage,
              createdAt: now,
              updatedAt: now,
            ),
          ),
    );
    if (!mounted) return;
    setState(() => _saving = false);
    if (done) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Vincular agricultor'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            initialValue: _farmerId,
            decoration: const InputDecoration(labelText: 'Agricultor'),
            items: [
              for (final farmer in widget.farmers)
                DropdownMenuItem(
                  value: farmer.id,
                  child: Text(farmer.fullName),
                ),
            ],
            onChanged: (value) => setState(() => _farmerId = value),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _percentage,
            decoration: const InputDecoration(
              labelText: 'Participación (%)',
              helperText: 'Opcional, entre 0 y 100',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: _saving || _farmerId == null ? null : _save,
          child: Text(_saving ? 'Guardando…' : 'Vincular'),
        ),
      ],
    );
  }
}

class _StatusActions extends ConsumerWidget {
  const _StatusActions({required this.parcel});

  final Parcel parcel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.read(parcelRepositoryProvider);
    Future<void> change(ParcelStatus status) async {
      final done = await runGuarded(
        context,
        () => repository.updateStatus(parcel.id, status),
      );
      if (done && context.mounted) {
        ref.invalidate(parcelProvider(parcel.id));
        ref.invalidate(parcelsProvider(const ParcelFilter()));
        showMessage(context, 'Estado actualizado a ${status.label}.');
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (parcel.status != ParcelStatus.active)
            FilledButton.icon(
              onPressed: () => change(ParcelStatus.active),
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Activar parcela'),
            ),
          if (parcel.status == ParcelStatus.active)
            OutlinedButton.icon(
              onPressed: () => change(ParcelStatus.inactive),
              icon: const Icon(Icons.pause_circle_outline),
              label: const Text('Desactivar parcela'),
            ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () async {
              final confirmed = await confirmAction(
                context,
                title: 'Eliminar parcela',
                message: 'Se eliminarán la geometría, las variedades, las '
                    'estimaciones y las fotografías de sus vértices. Esta '
                    'acción no se puede deshacer.',
                confirmLabel: 'Eliminar',
                destructive: true,
              );
              if (!confirmed || !context.mounted) return;
              final done = await runGuarded(
                context,
                () => repository.delete(parcel.id),
              );
              if (done && context.mounted) Navigator.of(context).pop();
            },
            icon: const Icon(Icons.delete_outline),
            label: const Text('Eliminar parcela'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}
