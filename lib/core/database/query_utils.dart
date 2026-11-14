/// Utilidades de consulta compartidas por los DAO.
library;

/// Patrón `LIKE` para búsquedas "contiene", con comodines escapados.
///
/// Se usa junto con `lower()` y `escapeChar: '\\'` para que un usuario pueda
/// buscar `%` o `_` sin alterar la consulta.
String likeContains(String input) {
  final escaped = input.trim().toLowerCase().replaceAllMapped(
        RegExp(r'[\\%_]'),
        (match) => '\\${match[0]}',
      );
  return '%$escaped%';
}
