import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/formatting/formatters.dart';
import '../../../core/validation/validators.dart';
import '../../../core/navigation/app_routes.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/feedback.dart';
import '../../../core/widgets/section_card.dart';
import '../../parcel_owners/data/parcel_owner_providers.dart';
import '../../parcel_owners/domain/entities/parcel_owner.dart';
import '../../parcels/data/parcel_providers.dart';
import '../../parcels/domain/entities/parcel.dart';
import '../data/farmer_providers.dart';
import '../domain/entities/farmer.dart';
import 'farmer_actions.dart';

/// Detalle de un agricultor y sus parcelas asociadas.
class FarmerDetailPage extends ConsumerWidget {
  const FarmerDetailPage({required this.farmerId, super.key});

  final String farmerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmer = ref.watch(farmerProvider(farmerId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agricultor'),
        actions: [
          farmer.maybeWhen(
            data: (data) => data == null
                ? const SizedBox.shrink()
                : IconButton(
                    tooltip: 'Editar',
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () => AppRoutes.push<void>(
                      context,
                      AppRoutes.farmerForm,
                      arguments: FarmerFormArgs(farmerId: data.id),
                    ),
                  ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: AsyncValueView<Farmer?>(
        value: farmer,
        isEmpty: (data) => data == null,
        emptyMessage: 'El agricultor no existe.',
        onRetry: () => ref.invalidate(farmerProvider(farmerId)),
        builder: (data) => _FarmerBody(farmer: data!),
      ),
    );
  }
}

class _FarmerBody extends ConsumerWidget {
  const _FarmerBody({required this.farmer});

  final Farmer farmer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final links = ref.watch(farmerParcelLinksProvider(farmer.id));
    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: [
        SectionCard(
          title: farmer.fullName,
          icon: Icons.person_outline,
          child: Column(
            children: [
              DetailRow(
                label: 'Documento',
                value: farmer.documentNumber ?? '—',
                icon: Icons.badge_outlined,
              ),
              DetailRow(
                label: 'Teléfono',
                value: farmer.phone ?? '—',
                icon: Icons.phone_outlined,
              ),
              DetailRow(
                label: 'Correo',
                value: farmer.email ?? '—',
                icon: Icons.mail_outline,
              ),
              DetailRow(
                label: 'Localidad',
                value: farmer.locality ?? '—',
                icon: Icons.place_outlined,
              ),
              DetailRow(
                label: 'Dirección',
                value: farmer.address ?? '—',
                icon: Icons.home_outlined,
              ),
              if (farmer.notes != null && farmer.notes!.isNotEmpty)
                DetailRow(
                  label: 'Observaciones',
                  value: farmer.notes!,
                  icon: Icons.notes_outlined,
                ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Registrado el ${Formatters.date(farmer.createdAt)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
        SectionCard(
          title: 'Parcelas asociadas',
          icon: Icons.landscape_outlined,
          trailing: TextButton.icon(
            onPressed: () => _linkParcel(context, ref),
            icon: const Icon(Icons.add),
            label: const Text('Vincular'),
          ),
          child: AsyncValueView<List<ParcelOwner>>(
            value: links,
            isEmpty: (data) => data.isEmpty,
            emptyMessage: 'Este agricultor aún no tiene parcelas asociadas.',
            onRetry: () =>
                ref.invalidate(farmerParcelLinksProvider(farmer.id)),
            builder: (data) => _OwnershipList(
              farmer: farmer,
              links: data,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: OutlinedButton.icon(
            onPressed: () => deleteFarmer(context, ref, farmer).then((deleted) {
              if (deleted && context.mounted) Navigator.of(context).pop();
            }),
            icon: const Icon(Icons.delete_outline),
            label: const Text('Eliminar agricultor'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _linkParcel(BuildContext context, WidgetRef ref) async {
    final parcels = ref.read(parcelRepositoryProvider);
    final linked = await ref.read(
      parcelOwnerRepositoryProvider,
    ).findByFarmer(farmer.id);
    final linkedIds = linked.map((link) => link.parcelId).toSet();
    final all = await parcels.findParcels();
    final available =
        all.where((parcel) => !linkedIds.contains(parcel.id)).toList();
    if (!context.mounted) return;
    if (available.isEmpty) {
      showMessage(context, 'No hay parcelas disponibles para vincular.');
      return;
    }
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => _LinkParcelDialog(
        farmer: farmer,
        parcels: available,
        linkedPercentages: linked
            .map((link) => link.ownershipPercentage)
            .whereType<double>()
            .toList(),
      ),
    );
  }
}

class _OwnershipList extends ConsumerWidget {
  const _OwnershipList({required this.farmer, required this.links});

  final Farmer farmer;
  final List<ParcelOwner> links;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parcels = ref.watch(parcelsProvider(const ParcelFilter()));
    final byId = <String, Parcel>{
      for (final parcel in parcels.asData?.value ?? const <Parcel>[])
        parcel.id: parcel,
    };
    final informed = links
        .map((link) => link.ownershipPercentage)
        .whereType<double>()
        .toList();
    final sum = informed.fold<double>(0, (total, value) => total + value);
    final shouldWarn = informed.isNotEmpty && (sum - 100).abs() > 0.01;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final link in links)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.landscape_outlined),
            title: Text(byId[link.parcelId]?.displayName ?? 'Parcela'),
            subtitle: Text(
              link.ownershipPercentage == null
                  ? 'Participación no informada'
                  : 'Participación ${Formatters.percent(link.ownershipPercentage)}',
            ),
            onTap: () => AppRoutes.push<void>(
              context,
              AppRoutes.parcelDetail,
              arguments: ParcelDetailArgs(parcelId: link.parcelId),
            ),
            trailing: IconButton(
              tooltip: 'Quitar vínculo',
              icon: const Icon(Icons.link_off),
              onPressed: () async {
                final confirmed = await confirmAction(
                  context,
                  title: 'Quitar vínculo',
                  message: 'La parcela y sus datos no se eliminan; solo se '
                      'quita la relación con este agricultor.',
                  confirmLabel: 'Quitar',
                  destructive: true,
                );
                if (!confirmed || !context.mounted) return;
                final done = await runGuarded(
                  context,
                  () => ref
                      .read(parcelOwnerRepositoryProvider)
                      .delete(link.id),
                );
                if (done && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Vínculo eliminado.')),
                  );
                }
              },
            ),
          ),
        if (shouldWarn)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
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
                    '${Formatters.percent(sum)}. Puedes guardarla igual, '
                    'pero conviene revisar los porcentajes.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _LinkParcelDialog extends ConsumerStatefulWidget {
  const _LinkParcelDialog({
    required this.farmer,
    required this.parcels,
    required this.linkedPercentages,
  });

  final Farmer farmer;
  final List<Parcel> parcels;
  final List<double> linkedPercentages;

  @override
  ConsumerState<_LinkParcelDialog> createState() => _LinkParcelDialogState();
}

class _LinkParcelDialogState extends ConsumerState<_LinkParcelDialog> {
  String? _parcelId;
  final TextEditingController _percentage = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _percentage.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final parcelId = _parcelId;
    if (parcelId == null) return;
    final percentageError = ValidatorsPercentage.validate(_percentage.text);
    if (percentageError != null) {
      showMessage(context, percentageError);
      return;
    }
    final percentage = ValidatorsPercentage.parse(_percentage.text);
    final informed = [
      ...widget.linkedPercentages,
      ?percentage,
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
              parcelId: parcelId,
              farmerId: widget.farmer.id,
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
      title: const Text('Vincular parcela'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            initialValue: _parcelId,
            decoration: const InputDecoration(labelText: 'Parcela'),
            items: [
              for (final parcel in widget.parcels)
                DropdownMenuItem(
                  value: parcel.id,
                  child: Text(parcel.displayName),
                ),
            ],
            onChanged: (value) => setState(() => _parcelId = value),
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
          onPressed: _saving || _parcelId == null ? null : _save,
          child: Text(_saving ? 'Guardando…' : 'Vincular'),
        ),
      ],
    );
  }
}

/// Validación local del porcentaje con mensajes de la capa compartida.
abstract final class ValidatorsPercentage {
  static String? validate(String value) {
    final text = value.trim();
    if (text.isEmpty) return null;
    final parsed = Validators.parsePlainDecimal(text);
    if (parsed == null || parsed < 0 || parsed > 100) {
      return 'La participación debe estar entre 0 y 100.';
    }
    return null;
  }

  static double? parse(String value) {
    final text = value.trim();
    if (text.isEmpty) return null;
    return Validators.parsePlainDecimal(text);
  }
}
