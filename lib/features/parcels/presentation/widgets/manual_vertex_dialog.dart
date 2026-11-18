import 'package:flutter/material.dart';

import '../../../../core/formatting/formatters.dart';
import '../../../../core/validation/validators.dart';

/// Diálogo para capturar o editar las coordenadas de un vértice manual.
///
/// Devuelve `{'lat': ..., 'lon': ...}` al confirmar, o `null` si se cancela.
/// Con [initialLatitude] y [initialLongitude] el diálogo funciona como edición:
/// precarga los valores y el botón pasa a «Guardar».
class ManualVertexDialog extends StatefulWidget {
  const ManualVertexDialog({
    this.initialLatitude,
    this.initialLongitude,
    super.key,
  });

  final double? initialLatitude;
  final double? initialLongitude;

  @override
  State<ManualVertexDialog> createState() => _ManualVertexDialogState();
}

class _ManualVertexDialogState extends State<ManualVertexDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _latitude;
  late final TextEditingController _longitude;

  bool get _isEditing =>
      widget.initialLatitude != null || widget.initialLongitude != null;

  @override
  void initState() {
    super.initState();
    _latitude = TextEditingController(
      text: widget.initialLatitude == null
          ? ''
          : Formatters.coordinate(widget.initialLatitude!),
    );
    _longitude = TextEditingController(
      text: widget.initialLongitude == null
          ? ''
          : Formatters.coordinate(widget.initialLongitude!),
    );
  }

  @override
  void dispose() {
    _latitude.dispose();
    _longitude.dispose();
    super.dispose();
  }

  String? _coordinateError(String? value, double limit) {
    final parsed = Validators.parsePlainDecimal(value);
    if (parsed == null) return 'Ingresa un número válido.';
    if (parsed < -limit || parsed > limit) {
      return 'Debe estar entre -$limit y $limit.';
    }
    return null;
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final lat = Validators.parsePlainDecimal(_latitude.text)!;
      final lon = Validators.parsePlainDecimal(_longitude.text)!;
      Navigator.of(context).pop({'lat': lat, 'lon': lon});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? 'Editar vértice manual' : 'Vértice manual'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _latitude,
              decoration: const InputDecoration(
                labelText: 'Latitud',
                hintText: '-17.783300',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ),
              validator: (value) => _coordinateError(value, 90),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _longitude,
              decoration: const InputDecoration(
                labelText: 'Longitud',
                hintText: '-63.182100',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ),
              validator: (value) => _coordinateError(value, 180),
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
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
          onPressed: _submit,
          child: Text(_isEditing ? 'Guardar' : 'Agregar'),
        ),
      ],
    );
  }
}
