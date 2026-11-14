import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/core_providers.dart';
import '../../../core/widgets/feedback.dart';
import '../../../core/widgets/section_card.dart';
import '../data/export_providers.dart';
import '../domain/services/export_service.dart';

/// Exportación de datos estructurados (JSON) y respaldo completo (ZIP).
class DataExportPage extends ConsumerStatefulWidget {
  const DataExportPage({super.key});

  @override
  ConsumerState<DataExportPage> createState() => _DataExportPageState();
}

class _DataExportPageState extends ConsumerState<DataExportPage> {
  ExportArtifact? _artifact;
  bool _busy = false;
  String _busyLabel = '';

  Future<void> _run(
    String label,
    Future<ExportArtifact> Function(ExportService service) action,
  ) async {
    setState(() {
      _busy = true;
      _busyLabel = label;
    });
    try {
      final artifact = await action(ref.read(exportServiceProvider));
      if (!mounted) return;
      setState(() => _artifact = artifact);
      showMessage(context, '${artifact.fileName} generado.');
    } catch (error) {
      if (mounted) showFailure(context, error);
    } finally {
      if (mounted) {
        setState(() {
          _busy = false;
          _busyLabel = '';
        });
      }
    }
  }

  Future<void> _share() async {
    final artifact = _artifact;
    if (artifact == null) return;
    final box = context.findRenderObject() as RenderBox?;
    await runGuarded(
      context,
      () => ref.read(shareServiceProvider).shareFile(
            artifact.filePath,
            subject: 'CatastroDemo · ${artifact.fileName}',
            sharePositionOrigin:
                box == null ? null : box.localToGlobal(Offset.zero) & box.size,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final artifact = _artifact;
    return Scaffold(
      appBar: AppBar(title: const Text('Exportar datos')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SectionCard(
            title: 'Contenido de la exportación',
            icon: Icons.info_outline,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'JSON incluye agricultores, parcelas, propietarios, '
                  'vértices, variedades, temporadas, unidades y estimaciones '
                  'en formato versionado. Las fechas se guardan en UTC '
                  '(ISO 8601) y los identificadores son UUID.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'El ZIP agrega las fotografías disponibles y un manifiesto '
                  'con la versión del esquema. Exportar no modifica ni '
                  'elimina datos locales.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: _busy
                ? null
                : () => _run('Generando JSON…', (service) => service.exportJson()),
            icon: const Icon(Icons.data_object),
            label: const Text('Exportar JSON'),
          ),
          const SizedBox(height: 8),
          FilledButton.tonalIcon(
            onPressed: _busy
                ? null
                : () => _run('Generando ZIP…', (service) => service.exportZip()),
            icon: const Icon(Icons.archive_outlined),
            label: const Text('Generar respaldo ZIP'),
          ),
          if (_busy) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: 12),
                Text(_busyLabel),
              ],
            ),
          ],
          if (artifact != null) ...[
            const SizedBox(height: 16),
            SectionCard(
              title: 'Último archivo generado',
              icon: Icons.check_circle_outline,
              child: Column(
                children: [
                  DetailRow(label: 'Archivo', value: artifact.fileName),
                  DetailRow(
                    label: 'Registros',
                    value: '${artifact.recordCount}',
                  ),
                  DetailRow(
                    label: 'Fotografías',
                    value: '${artifact.photoCount}',
                  ),
                  DetailRow(label: 'Tamaño', value: artifact.sizeLabel),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton.icon(
                      onPressed: _busy ? null : _share,
                      icon: const Icon(Icons.share_outlined),
                      label: const Text('Compartir archivo'),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 16),
          Text(
            'El archivo se guarda en el almacenamiento privado de la '
            'aplicación. Si el dispositivo no tiene espacio suficiente, se '
            'informará el error y no se modificará ningún dato.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
