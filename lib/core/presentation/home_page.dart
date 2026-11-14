import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../navigation/app_routes.dart';
import '../widgets/section_card.dart';
import '../../features/farmers/data/farmer_providers.dart';
import '../../features/parcels/data/parcel_providers.dart';

/// Pantalla inicial con resumen y accesos a los módulos.
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmerCount = ref.watch(farmerCountProvider);
    final parcelCount = ref.watch(parcelCountProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('CatastroDemo')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          SectionCard(
            title: 'Resumen',
            icon: Icons.insights_outlined,
            child: Row(
              children: [
                Expanded(
                  child: _CounterTile(
                    label: 'Agricultores',
                    value: farmerCount.when(
                      data: (value) => '$value',
                      loading: () => '…',
                      error: (_, _) => '—',
                    ),
                    icon: Icons.person_outline,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _CounterTile(
                    label: 'Parcelas',
                    value: parcelCount.when(
                      data: (value) => '$value',
                      loading: () => '…',
                      error: (_, _) => '—',
                    ),
                    icon: Icons.landscape_outlined,
                  ),
                ),
              ],
            ),
          ),
          SectionCard(
            title: 'Módulos',
            icon: Icons.apps,
            child: Column(
              children: [
                _ModuleTile(
                  icon: Icons.person_outline,
                  title: 'Agricultores',
                  subtitle: 'Registro, búsqueda y parcelas asociadas',
                  route: AppRoutes.farmers,
                ),
                _ModuleTile(
                  icon: Icons.landscape_outlined,
                  title: 'Parcelas',
                  subtitle: 'Mapa, vértices y superficies',
                  route: AppRoutes.parcels,
                ),
                _ModuleTile(
                  icon: Icons.eco_outlined,
                  title: 'Variedades de uva',
                  subtitle: 'Catálogo local editable',
                  route: AppRoutes.varieties,
                ),
                _ModuleTile(
                  icon: Icons.scale_outlined,
                  title: 'Producción',
                  subtitle: 'Temporadas, unidades y estimaciones',
                  route: AppRoutes.production,
                ),
                _ModuleTile(
                  icon: Icons.save_alt_outlined,
                  title: 'Exportar datos',
                  subtitle: 'JSON y respaldo ZIP',
                  route: AppRoutes.export,
                ),
              ],
            ),
          ),
          SectionCard(
            title: 'Alcance de la demo',
            icon: Icons.info_outline,
            child: Text(
              'Aplicación local sin backend ni sincronización. El mapa usa '
              'OpenStreetMap y requiere Internet; los datos guardados, los '
              'vértices y la superficie calculada funcionan sin conexión. La '
              'ubicación depende de los permisos y de la precisión del GPS '
              'del dispositivo. La superficie es aproximada y no reemplaza a '
              'un levantamiento topográfico.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _CounterTile extends StatelessWidget {
  const _CounterTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: theme.textTheme.titleLarge),
              Text(label, style: theme.textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}

class _ModuleTile extends StatelessWidget {
  const _ModuleTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.route,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(child: Icon(icon)),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => AppRoutes.push<void>(context, route),
    );
  }
}
