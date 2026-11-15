import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/core_providers.dart';
import '../../../core/formatting/formatters.dart';
import '../../../core/navigation/app_routes.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/feedback.dart';
import '../../parcel_owners/data/parcel_owner_providers.dart';
import '../data/parcel_providers.dart';
import '../domain/entities/parcel.dart';

/// Listado y búsqueda de parcelas.
class ParcelsListPage extends ConsumerStatefulWidget {
  const ParcelsListPage({super.key});

  @override
  ConsumerState<ParcelsListPage> createState() => _ParcelsListPageState();
}

class _ParcelsListPageState extends ConsumerState<ParcelsListPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  ParcelStatus? _status;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  ParcelFilter get _filter => ParcelFilter(query: _query, status: _status);

  @override
  Widget build(BuildContext context) {
    final parcels = ref.watch(parcelsProvider(_filter));
    return Scaffold(
      appBar: AppBar(title: const Text('Parcelas')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => AppRoutes.push<void>(
          context,
          AppRoutes.parcelForm,
          arguments: const ParcelFormArgs(),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Nueva parcela'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Buscar por código o nombre',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => setState(() => _query = value.trim()),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                ChoiceChip(
                  label: const Text('Todas'),
                  selected: _status == null,
                  onSelected: (_) => setState(() => _status = null),
                ),
                for (final status in ParcelStatus.values) ...[
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: Text(status.label),
                    selected: _status == status,
                    onSelected: (_) => setState(() => _status = status),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: AsyncValueView<List<Parcel>>(
              value: parcels,
              isEmpty: (data) => data.isEmpty,
              emptyMessage: _query.isEmpty && _status == null
                  ? 'Todavía no hay parcelas registradas.'
                  : 'No se encontraron parcelas con ese criterio.',
              onRetry: () => ref.invalidate(parcelsProvider(_filter)),
              builder: (data) => ListView.builder(
                padding: const EdgeInsets.only(bottom: 96),
                itemCount: data.length,
                itemBuilder: (context, index) =>
                    _ParcelTile(parcel: data[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ParcelTile extends ConsumerWidget {
  const _ParcelTile({required this.parcel});

  final Parcel parcel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        leading: parcel.imagePath != null
            ? FutureBuilder<File?>(
                future: ref.read(photoStorageProvider).resolve(parcel.imagePath!),
                builder: (context, snap) {
                  final file = snap.data;
                  if (file != null && file.existsSync()) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.file(file, width: 48, height: 48, fit: BoxFit.cover),
                    );
                  }
                  return const CircleAvatar(child: Icon(Icons.landscape_outlined));
                },
              )
            : const CircleAvatar(child: Icon(Icons.landscape_outlined)),
        title: Text(parcel.displayName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Wrap(
              spacing: 12,
              runSpacing: 4,
              children: [
                Text('Calculada: ${Formatters.area(parcel.calculatedAreaM2)} (${Formatters.hectares(parcel.calculatedAreaM2)})'),
                Text('Declarada: ${Formatters.area(parcel.declaredAreaM2)} (${Formatters.hectares(parcel.declaredAreaM2)})'),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              parcel.status.label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: parcel.status == ParcelStatus.active
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outline,
              ),
            ),
          ],
        ),
        isThreeLine: true,
        onTap: () => AppRoutes.push<void>(
          context,
          AppRoutes.parcelDetail,
          arguments: ParcelDetailArgs(parcelId: parcel.id),
        ),
        trailing: PopupMenuButton<String>(
          tooltip: 'Acciones',
          onSelected: (value) async {
            switch (value) {
              case 'edit':
                await AppRoutes.push<void>(
                  context,
                  AppRoutes.parcelForm,
                  arguments: ParcelFormArgs(parcelId: parcel.id),
                );
              case 'delete':
                await _deleteParcel(context, ref);
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

  Future<void> _deleteParcel(BuildContext context, WidgetRef ref) async {
    final confirmed = await confirmAction(
      context,
      title: 'Eliminar parcela',
      message: 'Se eliminarán la geometría, las variedades, las estimaciones '
          'y las fotografías de sus vértices. Esta acción no se puede '
          'deshacer.',
      confirmLabel: 'Eliminar',
      destructive: true,
    );
    if (!confirmed || !context.mounted) return;
    final done = await runGuarded(
      context,
      () => ref.read(parcelRepositoryProvider).delete(parcel.id),
    );
    if (done && context.mounted) {
      ref.invalidate(parcelOwnersProvider(parcel.id));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Parcela eliminada.')),
      );
    }
  }
}
