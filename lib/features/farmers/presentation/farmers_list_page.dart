import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/navigation/app_routes.dart';
import '../../../core/widgets/async_value_view.dart';
import '../data/farmer_providers.dart';
import '../domain/entities/farmer.dart';
import 'farmer_actions.dart';

/// Listado y búsqueda de agricultores.
class FarmersListPage extends ConsumerStatefulWidget {
  const FarmersListPage({super.key});

  @override
  ConsumerState<FarmersListPage> createState() => _FarmersListPageState();
}

class _FarmersListPageState extends ConsumerState<FarmersListPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final farmers = ref.watch(farmersProvider(_query));
    return Scaffold(
      appBar: AppBar(title: const Text('Agricultores')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => AppRoutes.push<void>(
          context,
          AppRoutes.farmerForm,
          arguments: const FarmerFormArgs(),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo agricultor'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar por nombre, documento o localidad',
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
          Expanded(
            child: AsyncValueView<List<Farmer>>(
              value: farmers,
              isEmpty: (data) => data.isEmpty,
              emptyMessage: _query.isEmpty
                  ? 'Todavía no hay agricultores registrados.'
                  : 'No se encontraron agricultores con ese criterio.',
              onRetry: () => ref.invalidate(farmersProvider(_query)),
              builder: (data) => ListView.builder(
                padding: const EdgeInsets.only(bottom: 96),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final farmer = data[index];
                  return _FarmerTile(farmer: farmer);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FarmerTile extends ConsumerWidget {
  const _FarmerTile({required this.farmer});

  final Farmer farmer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = [
      if (farmer.documentNumber != null) 'CI ${farmer.documentNumber}',
      if (farmer.locality != null) farmer.locality!,
      if (farmer.phone != null) farmer.phone!,
    ].join(' · ');
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            farmer.firstName.isEmpty ? '?' : farmer.firstName[0].toUpperCase(),
          ),
        ),
        title: Text(farmer.fullName),
        subtitle: details.isEmpty ? null : Text(details),
        onTap: () => AppRoutes.push<void>(
          context,
          AppRoutes.farmerDetail,
          arguments: FarmerDetailArgs(farmerId: farmer.id),
        ),
        trailing: PopupMenuButton<String>(
          tooltip: 'Acciones',
          onSelected: (value) async {
            switch (value) {
              case 'edit':
                await AppRoutes.push<void>(
                  context,
                  AppRoutes.farmerForm,
                  arguments: FarmerFormArgs(farmerId: farmer.id),
                );
              case 'delete':
                await deleteFarmer(context, ref, farmer);
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
}
