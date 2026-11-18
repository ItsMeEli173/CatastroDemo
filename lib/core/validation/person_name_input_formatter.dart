import 'package:flutter/services.dart';

/// Restringe un campo de texto a nombres de persona.
///
/// Deja pasar solo letras (incluidas las acentuadas, la diéresis y la Ñ) y
/// espacios simples entre palabras. El espacio **final** se conserva a
/// propósito: si se recortara, el usuario no podría escribir la segunda
/// palabra de un nombre compuesto. El recorte de extremos y la validación
/// definitiva viven en `Validators`.
class PersonNameInputFormatter extends TextInputFormatter {
  const PersonNameInputFormatter();

  static final RegExp _allowed = RegExp(r'[A-Za-zÁÉÍÓÚÜÑáéíóúüñ]');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final source = newValue.text;
    final end = newValue.selection.end.clamp(0, source.length);
    final buffer = StringBuffer();
    var lastWasSpace = false;
    var outLength = 0;
    var caret = 0;

    for (var i = 0; i < source.length; i++) {
      final char = source[i];
      if (char.trim().isEmpty) {
        // Sin espacio inicial y sin espacios consecutivos.
        if (outLength > 0 && !lastWasSpace) {
          buffer.write(' ');
          lastWasSpace = true;
          outLength++;
        }
      } else if (_allowed.hasMatch(char)) {
        buffer.write(char);
        lastWasSpace = false;
        outLength++;
      }
      // El cursor se recalcula siempre, incluso si el carácter se descartó.
      if (i + 1 == end) caret = outLength;
    }

    final text = buffer.toString();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: caret.clamp(0, text.length)),
    );
  }
}
