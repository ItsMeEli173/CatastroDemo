# CatastroDemo — implementación por fases

Objetivo: implementar la demo móvil Flutter descrita en `CatastroDemo-Requerimientos.md` (v1.0) respetando sus fases 0 a 9, la arquitectura por funcionalidades, SOLID y la persistencia local SQLite/Drift sin backend.
Rama: `feature/catastro-demo`. Entrega: `ask-on-risk` (commits por unidad de trabajo; push/PR/merge los decide el usuario).
Runner: `flutter test` + `flutter analyze` (Flutter 3.47.8 / Dart 3.13.7).

## Specs

Notación: `S<n>` requisito verificable. Los textos entre comillas son literales del documento de requerimientos.

- **S1 (Fase 0)** Existen los entregables de análisis: requisitos funcionales y no funcionales, glosario, casos de uso, reglas de negocio, modelo entidad-relación conceptual, flujos de navegación y matriz de validaciones. Se cumple: "No existen contradicciones entre propietarios y variedades", "Se distingue superficie declarada de calculada", "Se distingue estimación general de estimación por variedad", "Se definió qué incluye JSON y qué incluye ZIP".
- **S2 (Fase 1)** Viabilidad técnica comprobada con prototipos ejecutables: OSM con atribución, ubicación y permisos, puntos GPS, líneas y polígonos, cálculo de superficie WGS84 justificado y probado, SQLite/Drift con datos relacionados, fotografía local, JSON y ZIP. El método de área queda documentado con sus límites y probado con polígonos de referencia.
- **S3 (Fase 2)** Aplicación ejecutable con estructura por funcionalidades, Riverpod, entidades y objetos de valor de dominio, interfaces de repositorios y servicios, esquema Drift inicial con migraciones y transacciones, navegación, tema y manejo de errores. "Los widgets no acceden directamente a SQLite", "Las entidades de dominio no dependen de infraestructura", "Las pruebas base pasan".
- **S4 (Fase 3)** CRUD y búsqueda de agricultores; asociación muchos a muchos con parcelas; participación porcentual opcional con advertencia cuando la suma informada no es 100 %. "Un agricultor puede asociarse a muchas parcelas", "Una parcela puede tener muchos agricultores", "La participación de propietarios es independiente de la distribución de variedades", "Las modificaciones no eliminan información relacionada por accidente".
- **S5 (Fase 4)** Parcelas con mapa OSM, ubicación actual con permisos y precisión, vértices GPS y manuales ordenados, polígono dibujado, edición/eliminación/reordenamiento, validación de geometría, superficie en m² y ha separada de la declarada, persistencia y consulta. "Se registra una parcela con al menos tres vértices distintos", "El polígono se representa correctamente", "Los datos se conservan al cerrar y abrir la aplicación", "La superficie calculada se distingue de la declarada", "La falta de Internet no impide consultar coordenadas ni datos locales".
- **S6 (Fase 5)** Catálogo local editable de variedades con búsqueda, desactivación sin perder historial, asociación a parcelas, porcentajes de superficie con advertencia de suma, y superficies aproximadas cuando existe área. "Una parcela puede tener varias variedades", "Una variedad puede estar presente en varias parcelas", "La suma de porcentajes se valida o advierte apropiadamente", "Los porcentajes representan superficie y no producción".
- **S7 (Fase 6)** Temporadas, unidades con equivalencia configurable, estimaciones generales y por variedad, conversión `kilogramos_estimados = cantidad_original × factor_conversion_kg`, factor histórico conservado y reportes sin doble conteo. "Las estimaciones históricas no cambian al modificar el catálogo de unidades", "Los reportes no suman simultáneamente el total general y su desglose por variedad".
- **S8 (Fase 7)** Fotografías opcionales por vértice desde cámara o galería, guardadas en almacenamiento privado con nombre único y ruta relativa en SQLite, miniatura y previsualización, archivos faltantes tolerados, ciclo de vida definido al eliminar vértices y depuración de huérfanos. "Cada fotografía está asociada a un vértice concreto", "La imagen puede consultarse después de reiniciar la aplicación", "La ausencia de una imagen no afecta la consulta del vértice".
- **S9 (Fase 8)** Exportación JSON versionada con todas las entidades y relaciones, fechas UTC ISO 8601, UUID, vértices en orden, rutas relativas de fotografías, sin rutas absolutas; respaldo ZIP con JSON y fotografías; compartir/guardar; errores y falta de espacio informados; contrato documentado. "Una exportación no modifica ni elimina datos locales".
- **S10 (Fase 9)** Integración y entrega: flujos completos de extremo a extremo, persistencia tras reinicio, exportación correcta, pruebas unitarias, de widgets e integración SQLite en verde, análisis estático sin errores, APK de demo compilado y documentación actualizada. "La aplicación informa claramente las limitaciones de mapa y GPS".
- **S11 (Reglas transversales)** Sin backend, Supabase, Firebase, sincronización ni autenticación; sin SQL en widgets; dominio sin Drift/plugins; validaciones compartidas entre formularios y persistencia; migraciones versionadas; sin paquetes injustificados.

## Tasks

- [x] T1 — Fase 0: análisis funcional y definición del dominio (`docs/fase-0-analisis-funcional.md`). Inline. Commit `docs: add phase 0 functional analysis`.
- [x] T2 — Fase 1: viabilidad técnica (mapa, GPS, área, Drift, fotos, JSON/ZIP) (`docs/fase-1-viabilidad.md`). Inline. Commit `feat: validate technical feasibility`.
- [x] T3 — Fase 2: arquitectura, dominio, esquema Drift, DI, navegación, tema y pruebas base (`docs/arquitectura.md`). Inline. Commit `feat: add architecture foundation`.
- [x] T4 — Fase 3: agricultores y propietarios. Delegado (writer) + revisión inline. Commit `feat(farmers): add farmer and owner management`.
- [x] T5 — Fase 4: parcelas, mapa, GPS, vértices y superficies. Delegado (writer) + revisión inline. Commit `feat(parcels): add parcel mapping and geometry`.
- [x] T6 — Fase 5: catálogo y distribución de variedades. Delegado (writer) + revisión inline. Commit `feat(varieties): add grape variety catalog and distribution`.
- [x] T7 — Fase 6: temporadas, unidades y estimaciones de producción. Delegado (writer) + revisión inline. Commit `feat(production): add seasons units and estimates`.
- [x] T8 — Fase 7: fotografías de vértices. Delegado (writer) + revisión inline. Commit `feat(photos): add vertex photo management`.
- [x] T9 — Fase 8: exportación JSON y ZIP. Delegado (writer) + revisión inline. Commit `feat(export): add JSON and ZIP export`.
- [x] T10 — Fase 9: integración, pruebas y entrega (README, APK). Inline + verificación. Commit `test: add integration coverage and delivery docs`.

## Log

- **L1 (2026-11-13, pedido original del usuario):** "quiero que revises "CatastroDemo-Requerimientos" e implementes la aplicacion movil por las fases respetando la planificacion presente ahi".

### Decisiones y evidencia

- L2 — Se inicializa repositorio Git local y rama `feature/catastro-demo` (el directorio no era repositorio). Sin remoto configurado.
- L3 — Toolchain verificado: Flutter 3.47.8, Dart 3.13.7, Android SDK 36, JDK 21, red disponible. Sin dispositivo/emulador conectado: el APK se compila, la prueba en dispositivo real queda pendiente y se informa en la entrega.
- L4 — Dependencias resueltas por `flutter pub add` (versiones vigentes): flutter_riverpod 3.5, drift 2.35, drift_flutter 0.3, flutter_map 8.3, latlong2 0.10, geolocator 14.1, image_picker 1.2, path_provider 2.1, uuid 4.6, intl 0.20, share_plus 13.3, archive 4.7. `sqlite3_flutter_libs` resultó un placeholder EOL exigido por `drift_flutter`: se retira del pubspec propio y se documenta.
- L5 — Orden de fases respetado 0→9. Las secciones de variedades, producción y fotografías se integran en el detalle de parcela al finalizar cada fase, con edición inline del archivo de detalle (propiedad del orquestador) para evitar conflictos entre escritores.
- L6 — Autoría de commits: no existe identidad Git configurada. Los commits usan identidad local de marcador (`Elias <elias@localhost>`) solo para el repositorio local; el usuario puede reescribirla con `git commit --amend --reset-author`. Se informa en la entrega.
