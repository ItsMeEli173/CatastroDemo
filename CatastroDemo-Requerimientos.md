# CatastroDemo

## Documento maestro de planificación y especificación de la demo móvil

**Nombre del proyecto:** CatastroDemo  
**Tipo de producto:** aplicación móvil independiente  
**Tecnología principal:** Flutter y Dart  
**Persistencia:** SQLite local mediante Drift  
**Cartografía:** OpenStreetMap mediante `flutter_map`  
**Estado del alcance:** demo móvil local, sin backend  
**Versión del documento:** 1.0  
**Fecha:** 13 de noviembre de 2026

---

## 1. Resumen del proyecto

CatastroDemo es una aplicación móvil desarrollada con Flutter para registrar y consultar información de agricultores dedicados al cultivo de vid (uva) y de las parcelas asociadas a ellos. La aplicación permitirá delimitar terrenos mediante vértices geográficos, visualizar sus límites sobre un mapa, registrar variedades de uva y su distribución porcentual, adjuntar fotografías opcionales a los vértices y guardar estimaciones de producción.

La primera entrega será una **demo móvil autónoma**. Toda la información estructurada se guardará localmente en el dispositivo mediante SQLite. Las fotografías se guardarán como archivos locales y SQLite conservará sus metadatos y rutas relativas. La aplicación podrá exportar los datos estructurados a JSON y ofrecer un respaldo ZIP que incluya también las fotografías.

El proyecto no implementará un backend, una API propia, una base de datos remota ni sincronización entre dispositivos en esta etapa. La arquitectura debe mantener separada la lógica del negocio del mecanismo de persistencia para que, en una etapa futura, pueda incorporarse un backend propio sin rehacer los módulos funcionales.

## 2. Objetivo general

Construir una aplicación móvil funcional que permita registrar agricultores y parcelas vitícolas, delimitar geográficamente los terrenos, asociar propietarios y variedades, estimar la producción y conservar la información localmente con capacidad de exportación.

### 2.1 Objetivos específicos

- Registrar, consultar, editar y eliminar agricultores.
- Asociar varios agricultores a una misma parcela.
- Asociar varias parcelas a un mismo agricultor.
- Registrar los vértices que delimitan una parcela mediante GPS o selección manual en el mapa.
- Visualizar la parcela como un polígono sobre OpenStreetMap.
- Calcular y mostrar la superficie aproximada de la parcela.
- Registrar variedades de uva en un catálogo editable.
- Asociar una o varias variedades a cada parcela y registrar el porcentaje de superficie que representa cada una.
- Registrar estimaciones de producción por parcela, temporada y, opcionalmente, variedad.
- Convertir cantidades de cajones u otras unidades a kilogramos mediante factores configurables.
- Adjuntar opcionalmente fotografías a los vértices.
- Conservar la información sin conexión a Internet.
- Exportar los datos estructurados como JSON y ofrecer un respaldo completo con fotografías en ZIP.

## 3. Alcance de esta versión

### 3.1 Incluido en la demo

1. Aplicación Flutter para dispositivos móviles.
2. Persistencia local con SQLite/Drift.
3. Gestión de agricultores.
4. Gestión de parcelas.
5. Relación muchos a muchos entre agricultores y parcelas.
6. Participación porcentual de propietarios, cuando corresponda.
7. Mapa OpenStreetMap y visualización de la ubicación actual.
8. Captura de vértices mediante GPS y registro manual.
9. Dibujo, edición y validación de polígonos.
10. Cálculo de superficies y conversión entre metros cuadrados y hectáreas.
11. Catálogo editable de variedades de uva.
12. Porcentajes de superficie por variedad.
13. Temporadas agrícolas y estimaciones de producción.
14. Conversión configurable de cajones a kilogramos.
15. Fotografías opcionales asociadas a vértices.
16. Exportación JSON y respaldo ZIP con fotografías.
17. Pruebas unitarias, de widgets e integración local.

### 3.2 Fuera del alcance

No se debe desarrollar ni introducir en esta versión:

- Backend propio, API REST o GraphQL.
- Servidor externo o servidor local.
- Supabase, Firebase u otros servicios BaaS.
- PostgreSQL, PostGIS, MongoDB u otra base de datos remota.
- Inicio de sesión, autenticación remota o gestión de usuarios en servidor.
- Sincronización entre dispositivos.
- Panel administrativo web.
- Almacenamiento remoto de fotografías.
- Descarga masiva o precarga de mapas para uso offline desde los servidores públicos de OpenStreetMap.
- Predicción de producción mediante inteligencia artificial.
- Reconocimiento automático de variedades por imágenes.
- Integración catastral oficial o certificación topográfica.
- Gestión comercial de ventas, compras o inventario de uva.

La aplicación puede funcionar sin Internet para registrar y consultar sus datos. La cartografía base de OpenStreetMap, cuando se obtenga desde un proveedor online, requiere conexión. Sin conexión deben seguir disponibles las coordenadas, los vértices, los polígonos que puedan dibujarse sin teselas y el resto de la información local.

## 4. Usuarios y escenario de uso

La demo se plantea para una persona que utiliza un dispositivo móvil para levantar y consultar información de agricultores y parcelas en campo.

En esta etapa no existen cuentas ni roles remotos. Los datos pertenecen a la instalación local de CatastroDemo. Por tanto:

- No habrá inicio de sesión.
- No habrá separación de datos por usuario autenticado.
- La protección principal de los datos dependerá del almacenamiento privado de la aplicación y de las medidas del sistema operativo.
- El usuario debe poder generar exportaciones para respaldar o trasladar los datos.

## 5. Arquitectura y tecnologías

### 5.1 Decisión arquitectónica

Utilizar una arquitectura por funcionalidades, con separación entre presentación, dominio y datos. Puede emplearse MVVM en presentación, repositorios para el acceso a datos e inyección de dependencias mediante Riverpod.

Los casos de uso y las entidades de dominio no deben depender directamente de Flutter, SQLite, Drift, OpenStreetMap ni de plugins del sistema operativo.

### 5.2 Tecnologías propuestas

| Área | Tecnología o paquete | Responsabilidad |
|---|---|---|
| Aplicación | Flutter / Dart | Interfaz y lógica móvil. |
| Estado e inyección | Riverpod / `flutter_riverpod` | Estado, dependencias y ciclo de vida de servicios. |
| Mapa | `flutter_map` | Renderizado de OpenStreetMap, marcadores y polígonos. |
| Coordenadas | `latlong2` | Representación y operaciones básicas con latitud/longitud. |
| Ubicación | `geolocator` | Acceso a ubicación del dispositivo y precisión reportada. |
| Base local | SQLite mediante Drift | Persistencia estructurada, consultas y migraciones. |
| Fotografías | `image_picker` | Captura o selección de fotografías. |
| Rutas de archivos | `path_provider` | Directorios privados de almacenamiento de la aplicación. |
| Identificadores | `uuid` | Identificadores independientes de SQLite. |
| JSON | `json_serializable` | Serialización y deserialización de modelos de transferencia. |
| Exportación/compartir | `share_plus` y/o selector de archivos compatible | Entrega del JSON o ZIP al usuario. |
| Pruebas | `flutter_test` y herramientas de pruebas Dart | Pruebas unitarias, de widgets e integración. |

Las versiones concretas deben seleccionarse al iniciar el proyecto, verificando compatibilidad entre paquetes y versión de Flutter. No fijar versiones antiguas copiadas de ejemplos sin comprobar su vigencia.

### 5.3 Estructura sugerida del proyecto

```text
lib/
├── app/
│   ├── routing/
│   ├── theme/
│   └── app.dart
│
├── core/
│   ├── errors/
│   ├── result/
│   ├── constants/
│   ├── utils/
│   ├── database/
│   ├── files/
│   └── dependency_injection/
│
├── features/
│   ├── farmers/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── parcels/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── map/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── grape_varieties/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── production/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── vertex_photos/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── data_export/
│       ├── data/
│       ├── domain/
│       └── presentation/
│
└── main.dart

test/
├── unit/
├── widget/
└── integration/
```

La estructura es una guía, no una obligación de crear carpetas vacías. Cada funcionalidad debe incluir solamente las capas que necesite.

### 5.4 Flujo de dependencias

```text
Pantalla / Widget
      ↓
ViewModel / Notifier
      ↓
Caso de uso
      ↓
Interfaz del repositorio
      ↓
Implementación local del repositorio
      ↓
DAO / Drift
      ↓
SQLite
```

Servicios de ubicación, mapas y archivos deben quedar detrás de abstracciones cuando su uso afecte la lógica del dominio o cuando se necesite sustituirlos en pruebas.

## 6. Principios SOLID y reglas de desarrollo

Todos los agentes deben respetar los principios SOLID:

- **S — Responsabilidad única:** cada clase o módulo debe tener una responsabilidad clara.
- **O — Abierto/cerrado:** las funcionalidades deben poder ampliarse sin modificar innecesariamente módulos estables.
- **L — Sustitución de Liskov:** las implementaciones deben respetar el contrato de sus abstracciones.
- **I — Segregación de interfaces:** definir contratos pequeños y específicos.
- **D — Inversión de dependencias:** los casos de uso dependen de interfaces, no de implementaciones concretas.

Reglas obligatorias:

1. Ningún widget ejecutará consultas SQL directamente.
2. La lógica de negocio no conocerá Drift ni SQLite.
3. Los modelos de dominio no dependerán de paquetes de infraestructura.
4. Los cálculos de superficie y producción se implementarán en componentes de dominio o servicios puros y testeables.
5. El acceso a cámara, GPS, archivos y mapa estará encapsulado en servicios apropiados.
6. Las dependencias se inyectarán; se evitarán instancias globales ocultas.
7. Los errores se manejarán explícitamente y se comunicarán a presentación mediante estados o resultados controlados.
8. No se añadirán paquetes sin justificar su necesidad.
9. No se duplicará lógica de validación entre formularios y persistencia.
10. Cada cambio del esquema SQLite tendrá una migración y pruebas asociadas.

## 7. Modelo conceptual de datos

### 7.1 Entidades principales

| Entidad | Responsabilidad |
|---|---|
| `Farmer` | Datos generales de un agricultor. |
| `Parcel` | Identificación y datos generales de una parcela. |
| `ParcelOwner` | Asociación entre agricultor y parcela, con participación opcional. |
| `ParcelVertex` | Coordenada que forma parte del límite de una parcela. |
| `VertexPhoto` | Archivo fotográfico asociado a un vértice. |
| `GrapeVariety` | Catálogo editable de variedades de uva. |
| `ParcelVariety` | Variedad presente en una parcela y porcentaje de superficie. |
| `HarvestSeason` | Temporada o campaña agrícola. |
| `MeasurementUnit` | Unidad de registro y equivalencia en kilogramos. |
| `ProductionEstimate` | Estimación de producción para una parcela, temporada y variedad opcional. |

### 7.2 Relaciones

- Un agricultor puede estar relacionado con muchas parcelas.
- Una parcela puede tener muchos agricultores propietarios.
- `ParcelOwner` resuelve la relación muchos a muchos.
- Una parcela tiene muchos vértices, ordenados por `sequence_number`.
- Un vértice puede tener una o varias fotografías en el modelo de datos. Para simplificar la primera interfaz, se puede limitar inicialmente a una fotografía visible por vértice.
- Una parcela puede contener muchas variedades.
- Una variedad puede estar presente en muchas parcelas.
- `ParcelVariety` resuelve la relación entre parcelas y variedades y almacena el porcentaje cultivado.
- Una parcela puede tener estimaciones de producción en distintas temporadas.
- Una estimación puede ser general de la parcela o estar asociada a una variedad concreta.

### 7.3 Tablas y campos iniciales

Los campos siguientes son una propuesta inicial. El agente de arquitectura debe convertirlos en un esquema SQL/Drift coherente, agregar restricciones, claves e índices y documentar cualquier cambio.

#### `farmers`

- `id`: UUID, clave primaria.
- `first_name`: nombres.
- `last_name`: apellidos.
- `document_number`: opcional.
- `phone`: opcional.
- `email`: opcional.
- `locality`: comunidad o localidad, opcional.
- `address`: dirección o referencia, opcional.
- `notes`: observaciones, opcional.
- `created_at`, `updated_at`: fechas.

#### `parcels`

- `id`: UUID, clave primaria.
- `code`: código identificador único dentro de la instalación.
- `name`: nombre descriptivo, opcional.
- `declared_area_m2`: superficie declarada, opcional.
- `calculated_area_m2`: superficie calculada a partir de los vértices, opcional hasta disponer de geometría válida.
- `status`: estado del registro, por ejemplo activo o inactivo.
- `notes`: observaciones, opcional.
- `created_at`, `updated_at`: fechas.

La superficie declarada y la calculada deben permanecer separadas. La aplicación no debe sustituir silenciosamente una por otra.

#### `parcel_owners`

- `id`: UUID.
- `parcel_id`: referencia a `parcels`.
- `farmer_id`: referencia a `farmers`.
- `ownership_percentage`: porcentaje opcional de participación.
- `notes`: opcional.

Debe impedirse duplicar la asociación de un mismo agricultor con una misma parcela. Si se informan porcentajes para todos los propietarios, el sistema debe advertir si la suma no es 100 %. Se podrá guardar información incompleta como borrador, pero los datos definitivos deberán pasar las validaciones acordadas.

#### `parcel_vertices`

- `id`: UUID.
- `parcel_id`: referencia a `parcels`.
- `sequence_number`: orden del vértice dentro del polígono.
- `latitude`: latitud WGS84.
- `longitude`: longitud WGS84.
- `accuracy_m`: precisión reportada por el GPS, opcional para puntos manuales.
- `capture_method`: GPS o manual.
- `captured_at`: fecha de captura, opcional.
- `created_at`, `updated_at`: fechas.

La secuencia de vértices será la fuente local de verdad para reconstruir el polígono.

#### `vertex_photos`

- `id`: UUID.
- `vertex_id`: referencia a `parcel_vertices`.
- `relative_path`: ruta relativa al directorio privado de fotografías.
- `file_name`: nombre generado para el archivo.
- `description`: opcional.
- `created_at`: fecha.

No almacenar archivos binarios ni cadenas Base64 de fotografías dentro de SQLite como mecanismo normal.

#### `grape_varieties`

- `id`: UUID.
- `name`: nombre de la variedad.
- `category`: opcional, por ejemplo blanca o tinta si se decide clasificar.
- `description`: opcional.
- `aliases`: opcional; nombres alternativos pueden representarse en una tabla separada si se necesita búsqueda avanzada.
- `active`: indica si puede seleccionarse en nuevos registros.

El catálogo será editable. Los nombres iniciales son ejemplos y no constituyen una lista oficial ni exhaustiva: Moscatel de Alejandría, Malbec, Cabernet Sauvignon, Syrah y otras variedades que se definan con los usuarios del sistema.

#### `parcel_varieties`

- `id`: UUID.
- `parcel_id`: referencia a `parcels`.
- `grape_variety_id`: referencia a `grape_varieties`.
- `planted_area_percentage`: porcentaje de la superficie de la parcela correspondiente a la variedad.
- `notes`: opcional.

La suma de porcentajes debe advertirse cuando no alcance 100 % o lo supere. Se permitirá guardar registros incompletos durante la captura si se identifican como borradores. No confundir este porcentaje con la participación de propietarios.

#### `harvest_seasons`

- `id`: UUID.
- `name`: nombre de la campaña, por ejemplo `2026` o `2026-2027`.
- `start_date`: opcional.
- `end_date`: opcional.
- `notes`: opcional.

#### `measurement_units`

- `id`: UUID.
- `code`: código único, por ejemplo `kg`, `crate` o `ton`.
- `name`: nombre visible.
- `kilograms_equivalent`: equivalencia en kg por unidad, cuando sea fija.
- `active`: disponibilidad para nuevos registros.

La equivalencia de un cajón no debe suponerse universal. Debe ser configurable y puede variar según el recipiente o criterio local.

#### `production_estimates`

- `id`: UUID.
- `parcel_id`: referencia a `parcels`.
- `season_id`: referencia a `harvest_seasons`.
- `grape_variety_id`: referencia opcional a `grape_varieties`; nulo para estimación general.
- `quantity`: cantidad original registrada.
- `unit_id`: referencia a `measurement_units`.
- `conversion_factor_kg`: factor empleado en el momento del registro.
- `estimated_kg`: equivalente calculado en kilogramos.
- `notes`: opcional.
- `created_at`, `updated_at`: fechas.

Guardar el factor de conversión junto a la estimación es obligatorio para preservar el cálculo histórico si posteriormente cambia la configuración de la unidad.

### 7.4 Diferencia entre porcentajes

El sistema manejará dos porcentajes distintos:

**Participación de propietarios:** representa la parte de titularidad o participación asignada a cada agricultor en una parcela.

**Distribución de variedades:** representa la proporción de superficie de la parcela ocupada por cada variedad de uva.

Ejemplo de propietarios:

| Agricultor | Participación |
|---|---:|
| Agricultor A | 50 % |
| Agricultor B | 30 % |
| Agricultor C | 20 % |
| Total | 100 % |

Ejemplo de variedades en una parcela de 2 hectáreas:

| Variedad | Superficie porcentual | Superficie aproximada |
|---|---:|---:|
| Moscatel de Alejandría | 40 % | 0,8 ha |
| Malbec | 35 % | 0,7 ha |
| Cabernet Sauvignon | 25 % | 0,5 ha |
| Total | 100 % | 2 ha |

Los porcentajes de variedades representan superficie cultivada, no proporción de producción.

## 8. Requisitos geográficos y OpenStreetMap

### 8.1 Uso de OpenStreetMap

OpenStreetMap será únicamente la cartografía de fondo. Los datos propios de CatastroDemo —parcelas, vértices, propietarios, variedades y fotografías— permanecerán en SQLite y no se enviarán ni modificarán en OpenStreetMap.

La integración debe:

- Usar `flutter_map` y una capa de teselas configurable.
- Mostrar atribución visible de OpenStreetMap.
- Mantener separada la capa de cartografía de las capas de parcelas y vértices.
- Permitir mostrar la ubicación actual del dispositivo.
- Dibujar marcadores, líneas y polígonos propios.
- Manejar errores de conexión y ausencia de teselas.
- Evitar solicitudes excesivas y respetar las políticas del proveedor de teselas.

Los servidores públicos de teselas de OpenStreetMap no son un servicio ilimitado ni una garantía de disponibilidad. No se deben realizar descargas masivas ni precargar regiones para uso offline desde `tile.openstreetmap.org`. Si en el futuro se requieren mapas offline, deberá evaluarse un proveedor o una solución compatible con sus propias condiciones de uso.

### 8.2 Coordenadas

- Sistema de referencia: WGS84, latitud y longitud (EPSG:4326).
- Guardar latitud y longitud como valores numéricos con precisión suficiente.
- Guardar la precisión GPS reportada cuando el punto provenga del dispositivo.
- Registrar el método de captura: GPS o manual.
- No asumir que la posición GPS es exacta ni presentarla como levantamiento topográfico certificado.

### 8.3 Registro de vértices y polígonos

El usuario podrá:

1. Iniciar el registro de una parcela.
2. Capturar un vértice mediante GPS o seleccionarlo manualmente en el mapa.
3. Ver los vértices registrados y su orden.
4. Agregar nuevos vértices.
5. Eliminar, reemplazar o reordenar vértices.
6. Visualizar líneas entre puntos y el polígono resultante.
7. Guardar la parcela y recuperar su geometría a partir de los vértices.

Reglas mínimas:

- Se requieren al menos tres puntos distintos para formar una parcela.
- El cierre del polígono se hará al representarlo; no es necesario duplicar el primer vértice en la tabla.
- No aceptar coordenadas fuera de rango.
- Detectar puntos consecutivos duplicados.
- Validar que el polígono no se cruce consigo mismo.
- Rechazar geometrías de área nula o inválida.
- Permitir corregir vértices antes de confirmar el registro.

### 8.4 Cálculo de superficie

El cálculo se realizará en el dispositivo, sin PostGIS. El agente GIS debe seleccionar e implementar un método adecuado para calcular áreas geográficas a partir de coordenadas WGS84. No se debe tratar latitud y longitud como coordenadas cartesianas en grados ni calcular la superficie sumando distancias entre vértices.

Unidades de presentación:

- Metros cuadrados (m²).
- Hectáreas (ha), usando `1 ha = 10.000 m²`.

La superficie calculada será aproximada y se distinguirá de cualquier superficie declarada por el agricultor. El método elegido, sus límites y su precisión deben documentarse y probarse con polígonos de referencia.

### 8.5 Detección de superposiciones

La detección de posibles superposiciones entre parcelas es una funcionalidad secundaria. Puede implementarse si existe tiempo y una solución local fiable, pero no debe bloquear el MVP. Cualquier advertencia debe describirse como posible superposición, no como determinación legal de límites.

## 9. Gestión de agricultores y parcelas

### 9.1 Agricultores

Datos sugeridos:

- Nombres y apellidos.
- Documento de identidad, opcional.
- Teléfono, opcional.
- Correo electrónico, opcional.
- Comunidad o localidad.
- Dirección o referencia.
- Observaciones.

Debe permitir crear, ver, editar, buscar y eliminar agricultores respetando las relaciones existentes.

### 9.2 Parcelas

Datos sugeridos:

- Código identificador.
- Nombre descriptivo, opcional.
- Superficie declarada, opcional.
- Superficie calculada desde los vértices.
- Estado.
- Observaciones.
- Propietarios asociados.
- Vértices y polígono.
- Variedades cultivadas.
- Estimaciones de producción.

Una parcela debe poder consultarse desde el detalle de cualquiera de sus propietarios, y un agricultor debe mostrar todas las parcelas asociadas.

## 10. Variedades de uva

El catálogo debe permitir:

- Listar y buscar variedades.
- Registrar nuevas variedades.
- Editar sus nombres y descripciones.
- Desactivar variedades sin destruir el historial que las referencia.
- Asociar varias variedades a una parcela.
- Registrar el porcentaje de superficie de cada variedad.
- Mostrar la superficie aproximada que representa cada porcentaje, cuando exista una superficie calculada o declarada.

No codificar la lista de variedades directamente en widgets o validaciones. El catálogo debe almacenarse localmente y poder ampliarse desde la aplicación.

## 11. Estimación de producción

### 11.1 Requisitos

El usuario podrá registrar producción estimada:

- En kilogramos.
- En cajones.
- En otras unidades configurables si se justifican para el contexto de uso.
- Para una parcela y temporada.
- Para una variedad específica o para toda la parcela.

### 11.2 Conversión

Fórmula general:

`kilogramos_estimados = cantidad_original × factor_conversion_kg`

Ejemplo ilustrativo, no equivalente oficial:

- Cantidad: 25 cajones.
- Factor configurado: 20 kg/cajón.
- Equivalencia: 500 kg.

El peso de un cajón es configurable. La aplicación debe mostrar la cantidad original, la unidad, el factor aplicado y el resultado en kg.

### 11.3 Temporadas e historial

Las estimaciones deben conservarse por temporada. Crear una nueva temporada no debe sobrescribir las anteriores. Los reportes deben poder agrupar estimaciones por parcela, temporada y variedad.

Debe evitarse sumar simultáneamente una estimación general de la parcela y sus desgloses por variedad para no duplicar la producción. El modelo y las consultas deben distinguir claramente ambos modos de estimación.

## 12. Fotografías de vértices

Las fotografías son opcionales y pertenecen a un vértice específico.

Flujo esperado:

1. Abrir el detalle de una parcela o su mapa.
2. Seleccionar un vértice.
3. Elegir tomar una fotografía o seleccionar una existente.
4. Guardar el archivo en el almacenamiento privado de la aplicación.
5. Guardar en SQLite el identificador del vértice y los metadatos de la imagen.
6. Mostrar una miniatura o vista previa en el detalle del vértice.

Requisitos:

- No guardar imágenes Base64 como mecanismo de almacenamiento habitual.
- Generar nombres de archivo únicos.
- Evitar rutas absolutas dependientes de un dispositivo en el formato de exportación.
- Controlar el tamaño y, si corresponde, generar versiones comprimidas.
- Manejar archivos faltantes o dañados sin bloquear el resto de los datos.
- Si se elimina un vértice, solicitar o aplicar una regla clara para sus fotografías asociadas.

Para la primera demo se puede limitar la interfaz a una fotografía por vértice. El modelo debe evitar una limitación innecesaria que impida agregar más fotografías en una versión posterior.

## 13. Persistencia local y funcionamiento sin conexión

SQLite/Drift será la única base de datos de la demo.

Toda operación CRUD de agricultores, parcelas, propietarios, vértices, variedades, temporadas, estimaciones y metadatos de fotografías debe funcionar sin Internet.

La aplicación debe:

- Crear la base local durante la inicialización.
- Aplicar migraciones de esquema.
- Usar transacciones para operaciones que afecten varias tablas.
- Aplicar claves foráneas y restricciones de integridad.
- Definir índices para búsquedas habituales.
- Mantener los archivos fotográficos en almacenamiento privado.
- Manejar errores de lectura, escritura y falta de espacio.

No implementar cola de sincronización, estados de sincronización, reintentos remotos ni lógica de conflictos en esta versión.

## 14. Exportación de información

### 14.1 Exportación JSON

La aplicación debe permitir generar y compartir un archivo JSON con todos los datos estructurados relacionados.

Estructura ilustrativa:

```json
{
  "schema_version": "1.0",
  "app_name": "CatastroDemo",
  "exported_at": "2026-11-13T22:00:00Z",
  "farmers": [],
  "parcels": [],
  "parcel_owners": [],
  "vertices": [],
  "grape_varieties": [],
  "parcel_varieties": [],
  "harvest_seasons": [],
  "measurement_units": [],
  "production_estimates": [],
  "vertex_photos": []
}
```

El ejemplo representa la estructura general; cada arreglo contendrá objetos con sus campos. El nombre de las claves podrá ajustarse durante el diseño, pero debe documentarse y mantenerse estable para una misma versión del esquema.

Reglas del JSON:

- Incluir `schema_version`.
- Incluir nombre de aplicación y fecha de exportación en formato ISO 8601.
- Exportar UUID y conservar referencias entre entidades.
- Exportar fechas de forma consistente, preferentemente UTC.
- Exportar cantidades y factores de conversión originales.
- Exportar los vértices en su orden de secuencia.
- Incluir metadatos de fotografías y rutas relativas, no rutas absolutas del dispositivo.
- No incluir credenciales, secretos ni datos internos innecesarios del dispositivo.
- Generar el archivo desde una lectura consistente de la base de datos.
- Informar claramente si la exportación se completó o falló.

El JSON por sí solo contiene los datos estructurados y metadatos de fotografías, pero no necesariamente los archivos binarios de las imágenes.

### 14.2 Respaldo ZIP completo

Además de JSON, se recomienda ofrecer un archivo ZIP que contenga el JSON y las fotografías.

Estructura ilustrativa:

```text
CatastroDemo_backup_YYYYMMDD.zip
├── manifest.json
└── photos/
    ├── photo_<uuid>.jpg
    └── photo_<uuid>.jpg
```

`manifest.json` puede incluir la versión del esquema, fecha de exportación y relación entre archivos e identificadores de fotografías.

### 14.3 Importación

La importación de JSON o ZIP no es requisito del MVP. No obstante, el formato versionado y los UUID deben diseñarse para que la importación futura sea viable. No desarrollar una importación parcial o insegura solamente para anticipar el backend.

## 15. Pantallas principales sugeridas

La interfaz puede organizarse en las siguientes secciones:

1. **Inicio:** resumen de agricultores, parcelas y accesos rápidos.
2. **Agricultores:** listado, búsqueda, formulario y detalle.
3. **Parcelas:** listado, búsqueda y detalle.
4. **Mapa:** ubicación actual, selección de puntos y visualización de polígonos.
5. **Registro de parcela:** datos generales, propietarios, extensión y acceso a delimitación.
6. **Vértices:** listado ordenado, coordenadas, precisión y fotografías.
7. **Variedades:** catálogo y asociaciones por parcela.
8. **Producción:** temporadas, unidades, estimaciones y equivalencias en kg.
9. **Exportación:** generar JSON o ZIP y compartir/guardar el archivo.

La navegación y el diseño visual deben priorizar el uso en campo: controles legibles, formularios claros, confirmaciones antes de operaciones destructivas e indicación visible de cuándo un mapa de fondo no está disponible.

## 16. Fases de desarrollo e iteraciones

Cada fase se considera terminada cuando se cumplen sus criterios de aceptación, se ejecutan las pruebas necesarias y se documentan las decisiones. El número de iteraciones no es fijo: se pueden añadir todas las necesarias.

### Fase 0 — Análisis funcional y definición del dominio

**Objetivo:** cerrar requisitos, reglas y casos de uso antes de implementar.

Iteraciones:

- 0.1 Identificar actores y escenarios de uso.
- 0.2 Definir datos obligatorios y opcionales de agricultores.
- 0.3 Definir datos y estados de parcelas.
- 0.4 Definir relación muchos a muchos y participación de propietarios.
- 0.5 Definir catálogo de variedades y porcentajes de superficie.
- 0.6 Definir temporadas, unidades y estimaciones.
- 0.7 Definir captura de vértices y fotografías.
- 0.8 Definir reglas de validación y eliminación.
- 0.9 Definir pantallas y navegación.
- 0.10 Revisar contradicciones y aprobar especificación.

Entregables:

- Requisitos funcionales y no funcionales.
- Glosario del dominio.
- Casos de uso.
- Reglas de negocio.
- Modelo entidad-relación conceptual.
- Flujos de navegación.
- Matriz de validaciones.

Criterios de aceptación:

- No existen contradicciones entre propietarios y variedades.
- Se conoce qué datos pueden quedar incompletos.
- Se distingue superficie declarada de calculada.
- Se distingue estimación general de estimación por variedad.
- Se definió qué incluye JSON y qué incluye ZIP.

### Fase 1 — Pruebas técnicas de viabilidad

**Objetivo:** comprobar los riesgos técnicos principales mediante prototipos pequeños.

Iteraciones:

- 1.1 Crear un proyecto Flutter mínimo.
- 1.2 Mostrar teselas de OpenStreetMap con atribución.
- 1.3 Mostrar ubicación actual y gestionar permisos.
- 1.4 Capturar y visualizar puntos GPS.
- 1.5 Dibujar líneas y polígonos sobre el mapa.
- 1.6 Validar geometrías y calcular superficie en WGS84.
- 1.7 Crear una base SQLite mediante Drift.
- 1.8 Guardar y recuperar datos relacionados.
- 1.9 Capturar una fotografía y guardarla localmente.
- 1.10 Generar un JSON de prueba.
- 1.11 Generar un ZIP de prueba con fotografías.

Entregables:

- Prototipo de mapa.
- Prueba de GPS.
- Prueba de cálculo geográfico.
- Prueba de persistencia local.
- Prueba de almacenamiento fotográfico.
- Pruebas de exportación.
- Registro de riesgos y decisiones técnicas.

Criterios de aceptación:

- Se puede mostrar OSM con atribución.
- Se pueden representar puntos y polígonos.
- El método de cálculo de superficie está justificado y probado.
- Los datos se guardan y recuperan localmente.
- JSON y ZIP se generan correctamente.

### Fase 2 — Arquitectura y configuración inicial

**Objetivo:** crear la base técnica compartida por todos los módulos.

Iteraciones:

- 2.1 Configurar Flutter, formato y análisis estático.
- 2.2 Crear estructura por funcionalidades.
- 2.3 Configurar Riverpod e inyección de dependencias.
- 2.4 Definir entidades y objetos de valor de dominio.
- 2.5 Definir interfaces de repositorios y servicios.
- 2.6 Configurar Drift y esquema inicial.
- 2.7 Configurar migraciones y transacciones.
- 2.8 Configurar navegación, tema y manejo de errores.
- 2.9 Crear pruebas base y documentación para agentes.

Entregables:

- Aplicación ejecutable.
- Estructura aprobada.
- Dependencias configuradas.
- Base de datos inicial.
- Contratos de repositorios.
- Convenciones de código y pruebas.

Criterios de aceptación:

- La aplicación inicia sin errores.
- Se puede ejecutar una operación local de ejemplo.
- Los widgets no acceden directamente a SQLite.
- Las entidades de dominio no dependen de infraestructura.
- Las pruebas base pasan.

### Fase 3 — Módulo de agricultores y propietarios

**Objetivo:** administrar agricultores y relaciones de propiedad.

Iteraciones:

- 3.1 Crear formulario de agricultor.
- 3.2 Validar datos y campos opcionales.
- 3.3 Implementar alta, consulta, edición y eliminación.
- 3.4 Crear listado y búsqueda.
- 3.5 Crear detalle del agricultor.
- 3.6 Crear asociación de agricultor con parcelas.
- 3.7 Crear asignación de varios propietarios a una parcela.
- 3.8 Implementar participación porcentual.
- 3.9 Validar porcentajes y duplicados.
- 3.10 Probar integridad referencial y casos límite.

Criterios de aceptación:

- Un agricultor puede asociarse a muchas parcelas.
- Una parcela puede tener muchos agricultores.
- La participación de propietarios es independiente de la distribución de variedades.
- Las modificaciones no eliminan información relacionada por accidente.

### Fase 4 — Parcelas, mapa y geolocalización

**Objetivo:** registrar parcelas y delimitar sus polígonos.

Iteraciones:

- 4.1 Crear listado y formulario de parcelas.
- 4.2 Integrar mapa OSM.
- 4.3 Mostrar ubicación actual.
- 4.4 Gestionar permisos y precisión GPS.
- 4.5 Registrar vértices con GPS.
- 4.6 Registrar vértices manualmente.
- 4.7 Mostrar marcadores y orden de vértices.
- 4.8 Conectar vértices y dibujar polígono.
- 4.9 Editar, eliminar y reordenar vértices.
- 4.10 Validar polígonos.
- 4.11 Calcular superficie aproximada.
- 4.12 Mostrar m² y hectáreas.
- 4.13 Guardar y recuperar parcelas y vértices.
- 4.14 Mostrar mapa y detalle de una parcela existente.
- 4.15 Evaluar detección de superposiciones como mejora secundaria.
- 4.16 Probar en dispositivos reales y en condiciones de campo.

Criterios de aceptación:

- Se registra una parcela con al menos tres vértices distintos.
- El polígono se representa correctamente.
- Se pueden corregir puntos antes de confirmar.
- Los datos se conservan al cerrar y abrir la aplicación.
- La superficie calculada se distingue de la declarada.
- La falta de Internet no impide consultar coordenadas ni datos locales.

### Fase 5 — Catálogo y distribución de variedades

**Objetivo:** administrar variedades y su distribución por parcela.

Iteraciones:

- 5.1 Diseñar catálogo local.
- 5.2 Crear variedades iniciales configurables.
- 5.3 Implementar búsqueda y administración del catálogo.
- 5.4 Asociar variedades a parcelas.
- 5.5 Registrar porcentajes de superficie.
- 5.6 Validar duplicados y rangos porcentuales.
- 5.7 Permitir editar o retirar asociaciones.
- 5.8 Mostrar composición de variedades y superficies aproximadas.
- 5.9 Crear pruebas de consistencia.

Criterios de aceptación:

- Una parcela puede tener varias variedades.
- Una variedad puede estar presente en varias parcelas.
- La suma de porcentajes se valida o advierte apropiadamente.
- Los porcentajes representan superficie y no producción.

### Fase 6 — Estimaciones de producción

**Objetivo:** registrar cantidades y convertirlas a kilogramos.

Iteraciones:

- 6.1 Definir unidades iniciales.
- 6.2 Configurar equivalencias de unidades.
- 6.3 Registrar cantidades en kg.
- 6.4 Registrar cantidades en cajones.
- 6.5 Calcular equivalencias en kg.
- 6.6 Crear temporadas agrícolas.
- 6.7 Registrar estimaciones generales por parcela.
- 6.8 Registrar estimaciones por variedad.
- 6.9 Mostrar resúmenes por parcela y temporada.
- 6.10 Probar conversiones y evitar doble conteo.

Criterios de aceptación:

- El usuario puede configurar el peso por cajón.
- Cada estimación conserva el factor utilizado.
- Las estimaciones históricas no cambian al modificar el catálogo de unidades.
- Los reportes no suman simultáneamente el total general y su desglose por variedad.

### Fase 7 — Fotografías asociadas a vértices

**Objetivo:** adjuntar y consultar imágenes de puntos del terreno.

Iteraciones:

- 7.1 Diseñar el flujo de captura.
- 7.2 Capturar desde cámara.
- 7.3 Seleccionar desde galería.
- 7.4 Guardar archivos en almacenamiento privado.
- 7.5 Asociar metadatos al vértice.
- 7.6 Mostrar miniaturas y previsualización.
- 7.7 Controlar tamaño y formatos.
- 7.8 Manejar archivos faltantes y errores.
- 7.9 Probar ciclo de vida al editar o eliminar vértices.

Criterios de aceptación:

- Cada fotografía está asociada a un vértice concreto.
- La imagen puede consultarse después de reiniciar la aplicación.
- La ausencia de una imagen no afecta la consulta del vértice.
- La gestión de archivos huérfanos está definida.

### Fase 8 — Exportación JSON y ZIP

**Objetivo:** permitir respaldar y trasladar la información fuera de la aplicación.

Iteraciones:

- 8.1 Definir el contrato de exportación y versión del esquema.
- 8.2 Crear serializadores para cada entidad.
- 8.3 Exportar todos los registros y relaciones a JSON.
- 8.4 Validar UUID, fechas y referencias.
- 8.5 Incluir metadatos y rutas relativas de fotografías.
- 8.6 Generar ZIP con JSON y archivos fotográficos.
- 8.7 Implementar selección de destino o compartir archivo.
- 8.8 Manejar errores, cancelaciones y falta de espacio.
- 8.9 Probar exportaciones con datos completos y vacíos.
- 8.10 Documentar el contrato para futuros consumidores externos.

Criterios de aceptación:

- El JSON contiene todas las entidades y sus relaciones.
- No se exportan rutas absolutas del dispositivo.
- El ZIP incluye el JSON y las fotografías referenciadas disponibles.
- El formato tiene versión y documentación.
- Una exportación no modifica ni elimina datos locales.

### Fase 9 — Integración, pruebas y entrega

**Objetivo:** asegurar que la demo completa sea estable y demostrable.

Iteraciones:

- 9.1 Integrar todos los módulos.
- 9.2 Revisar navegación y consistencia visual.
- 9.3 Ejecutar pruebas unitarias.
- 9.4 Ejecutar pruebas de widgets.
- 9.5 Ejecutar pruebas de integración de SQLite.
- 9.6 Probar cálculos geográficos con casos conocidos.
- 9.7 Probar permisos GPS y cámara.
- 9.8 Probar funcionamiento sin Internet.
- 9.9 Probar exportación JSON y ZIP.
- 9.10 Revisar seguridad local y tratamiento de errores.
- 9.11 Corregir problemas de rendimiento y almacenamiento.
- 9.12 Preparar APK de demo y documentación.

Criterios de aceptación:

- Los flujos principales pueden completarse de principio a fin.
- Los registros persisten después de cerrar y volver a abrir la app.
- Los datos pueden exportarse correctamente.
- No hay errores críticos en pruebas.
- La aplicación informa claramente las limitaciones de mapa y GPS.
- La demo puede instalarse y presentarse en un dispositivo objetivo.

## 17. Casos de prueba mínimos

### Agricultores y propietarios

- Registrar un agricultor con datos completos.
- Registrar un agricultor con datos opcionales vacíos.
- Asociar un agricultor a varias parcelas.
- Asociar varios agricultores a una parcela.
- Intentar duplicar una asociación.
- Introducir porcentajes inferiores, iguales y superiores a 100 %.
- Eliminar o editar una asociación sin borrar al agricultor.

### Geografía

- Parcela con menos de tres vértices.
- Parcela con tres vértices distintos.
- Vértices duplicados consecutivos.
- Coordenadas fuera de rango.
- Polígono que se cruza consigo mismo.
- Polígono de área nula.
- Vértices en orden incorrecto.
- GPS con baja precisión.
- Captura manual sin GPS.
- Mapa sin conexión.

### Variedades

- Una parcela con una variedad.
- Una parcela con varias variedades.
- Una variedad asociada a parcelas diferentes.
- Variedad duplicada en una parcela.
- Porcentajes incompletos o superiores a 100 %.
- Desactivación de una variedad usada históricamente.

### Producción

- Registro directo en kg.
- Registro por cajones con factor configurable.
- Cambio del factor después de guardar una estimación.
- Estimaciones de temporadas distintas.
- Estimación general y desglose por variedad.
- Cantidades cero, negativas o inválidas.

### Fotografías y exportación

- Capturar una fotografía.
- Seleccionar una imagen existente.
- Adjuntar imagen a un vértice.
- Eliminar un vértice con fotografía asociada.
- Consultar un registro cuya imagen ya no existe.
- Exportar sin fotografías.
- Exportar con fotografías.
- Exportar una base vacía.
- Exportar datos con múltiples relaciones.
- Verificar que las relaciones por UUID se conservan en JSON.

## 18. Organización y delegación a agentes

### 18.1 Roles sugeridos

| Agente | Responsabilidad | Fases principales |
|---|---|---|
| Agente 1 — Analista | Requisitos, casos de uso y reglas del dominio. | 0 |
| Agente 2 — Arquitecto Flutter | Estructura, contratos, SOLID y persistencia local. | 1 y 2 |
| Agente 3 — Agricultores | CRUD y asociaciones de propietarios. | 3 |
| Agente 4 — GIS | Mapa, GPS, vértices, polígonos y superficies. | 4 |
| Agente 5 — Cultivos | Catálogo y porcentajes de variedades. | 5 |
| Agente 6 — Producción | Temporadas, unidades y conversiones. | 6 |
| Agente 7 — Multimedia | Cámara, archivos y asociaciones fotográficas. | 7 |
| Agente 8 — Exportación | JSON, ZIP y documentación del formato. | 8 |
| Agente 9 — QA e integración | Pruebas, revisión e integración final. | 9 |

Una persona o agente puede asumir más de un rol. Los roles definen responsabilidades, no una obligación de utilizar nueve agentes distintos.

### 18.2 Orden y paralelismo

Las fases 0, 1 y 2 deben completarse antes de delegar módulos funcionales en paralelo.

Después de aprobar el modelo de dominio, los módulos de agricultores, GIS, variedades y producción pueden desarrollarse en paralelo si respetan los contratos compartidos. Fotografías y exportación dependen de que estén definidos los identificadores y modelos de vértices y demás entidades.

El agente de arquitectura debe aprobar cambios a modelos compartidos, nombres de campos, contratos de repositorios y migraciones. El agente de QA debe validar la integración, no limitarse a probar módulos aislados.

### 18.3 Ciclo iterativo obligatorio

Cada agente seguirá este ciclo:

1. **Analizar:** leer este documento, los requisitos de su fase y el código existente.
2. **Diseñar:** proponer entidades, interfaces, pantallas y comportamiento antes de implementar.
3. **Dividir:** separar el trabajo en iteraciones pequeñas y verificables.
4. **Implementar:** trabajar exclusivamente dentro de las responsabilidades asignadas.
5. **Probar:** añadir y ejecutar pruebas.
6. **Revisar:** comprobar requisitos, SOLID, compatibilidad y regresiones.
7. **Corregir:** resolver observaciones y repetir pruebas.
8. **Entregar:** documentar cambios, decisiones, limitaciones y pasos de integración.

### 18.4 Reglas de colaboración

- Usar ramas independientes por funcionalidad o agente.
- Integrar mediante revisión de cambios.
- No modificar módulos ajenos sin justificación y coordinación.
- No cambiar contratos compartidos unilateralmente.
- No añadir backend, Supabase, Firebase ni sincronización.
- No duplicar entidades o reglas de negocio.
- Documentar migraciones de SQLite.
- Mantener pruebas junto al código que validan.
- Comunicar dependencias y bloqueos concretos.

### 18.5 Plantilla de encargo para cada agente

Cada encargo debe completar los campos de fase, iteración, archivos y criterios antes de asignarse.

```text
# Encargo para agente — CatastroDemo

## Contexto
Estás trabajando en CatastroDemo, una aplicación móvil Flutter para registrar
agricultores y parcelas vitícolas. La demo es autónoma y utiliza SQLite local.
No existe backend ni sincronización remota.

## Fase e iteración asignadas
[Indicar fase, iteración y objetivo concreto]

## Responsabilidades
[Enumerar únicamente las tareas asignadas]

## Contratos y módulos relacionados
[Indicar entidades, interfaces y funcionalidades con las que debe integrarse]

## Restricciones obligatorias
- Respetar los principios SOLID.
- Respetar la arquitectura por funcionalidades.
- Usar repositorios e interfaces para persistencia.
- No ejecutar SQL desde widgets.
- No acoplar dominio a Drift o plugins.
- No introducir backend, Supabase, Firebase ni sincronización.
- No modificar contratos compartidos sin coordinación.
- No añadir dependencias sin justificación.

## Iteraciones
Dividir el trabajo en cambios pequeños. Para cada iteración indicar:
- objetivo;
- diseño propuesto;
- archivos afectados;
- implementación;
- pruebas;
- resultado y observaciones.

## Entregables
- Análisis breve.
- Diseño técnico.
- Código implementado.
- Pruebas añadidas y resultado de ejecución.
- Migraciones, si corresponden.
- Archivos modificados.
- Dependencias nuevas y justificación.
- Limitaciones o problemas conocidos.
- Instrucciones para integrar y verificar.

## Criterio de finalización
No declarar terminada la tarea hasta cumplir los criterios de aceptación
asignados, ejecutar las pruebas y comprobar que la implementación respeta
los contratos y no introduce regresiones.
```

## 19. Definición de terminado (Definition of Done)

Una funcionalidad se considera terminada cuando:

- Cumple los requisitos funcionales asignados.
- Respeta la arquitectura y SOLID.
- Tiene validaciones y manejo de errores.
- Incluye pruebas apropiadas.
- Las pruebas relevantes pasan.
- No contiene dependencias o código no justificados.
- No rompe las funcionalidades ya integradas.
- La documentación está actualizada.
- El agente informa claramente qué no pudo completar.

Una fase se considera terminada cuando todas sus funcionalidades obligatorias cumplen su Definition of Done y el agente responsable entrega un informe de aceptación.

## 20. Riesgos y decisiones pendientes

| Riesgo o decisión | Tratamiento propuesto |
|---|---|
| GPS con precisión insuficiente | Guardar precisión, mostrar advertencia y permitir corrección manual. |
| Diferentes métodos de cálculo de área | Elegir y documentar un método geográfico probado en la fase 1. |
| Falta de Internet para cartografía | Mantener datos locales y mostrar claramente que las teselas no están disponibles. |
| Uso de teselas públicas OSM | Respetar atribución y política; no descargar masivamente ni asumir disponibilidad garantizada. |
| Peso variable de cajones | Factor configurable y guardado en cada estimación. |
| Cambio de esquema SQLite | Migraciones versionadas y pruebas de actualización. |
| Pérdida o desinstalación del dispositivo | Exportación JSON y ZIP; advertir que los datos locales pueden perderse al desinstalar. |
| Archivos fotográficos faltantes | Detectar rutas no válidas y permitir que el resto de los datos siga consultándose. |
| Confusión entre porcentajes | Mantener campos y pantallas separados para propietarios y variedades. |
| Doble conteo de producción | Distinguir estimaciones generales de estimaciones por variedad. |
| Crecimiento futuro hacia backend | UUID, JSON versionado, dominio desacoplado y repositorios. |

Decisiones que deben confirmarse durante el análisis o las pruebas:

- Plataforma y versiones mínimas de Android/iOS que se van a demostrar.
- Campos personales realmente necesarios para un agricultor.
- Si la participación de propietarios es obligatoria, opcional o solo informativa.
- Si las superficies y porcentajes se capturarán como datos aproximados o deberán seguir reglas adicionales.
- Peso o tipos de cajones usados localmente.
- Lista inicial de variedades de uva relevantes para los agricultores participantes.
- Si se limitará a una fotografía por vértice en la primera interfaz.
- Si la detección de superposiciones se implementará en la demo o quedará como mejora.

Estas decisiones no deben convertirse en funcionalidades adicionales sin aprobación del responsable del proyecto.

## 21. Resultado esperado de la demo

La demo estará lista cuando una persona pueda, desde un dispositivo móvil:

1. Registrar un agricultor.
2. Crear una parcela y asociarle uno o varios agricultores.
3. Delimitar la parcela mediante puntos GPS o manuales.
4. Visualizar los vértices y el polígono sobre OpenStreetMap cuando haya conexión.
5. Consultar la superficie aproximada calculada.
6. Asociar variedades y porcentajes de superficie.
7. Registrar una estimación por temporada, en cajones o kilogramos.
8. Consultar la equivalencia estimada en kilogramos.
9. Adjuntar una fotografía opcional a un vértice.
10. Cerrar y abrir la aplicación sin perder los datos.
11. Exportar los datos estructurados a JSON.
12. Generar un respaldo ZIP con JSON y fotografías.

El resultado será una aplicación móvil local, instalable y demostrable, preparada para que una fase futura incorpore un backend propio si el proyecto lo requiere.

---

## 22. Referencias técnicas para consultar durante el desarrollo

Los agentes deben verificar la documentación vigente antes de fijar versiones o depender de comportamientos concretos.

- Flutter: https://docs.flutter.dev/
- Arquitectura recomendada de Flutter: https://docs.flutter.dev/app-architecture
- Persistencia SQLite con Flutter: https://docs.flutter.dev/cookbook/persistence/sqlite
- `flutter_map`: https://pub.dev/packages/flutter_map
- `latlong2`: https://pub.dev/packages/latlong2
- `geolocator`: https://pub.dev/packages/geolocator
- Drift: https://drift.simonbinder.eu/
- Riverpod: https://riverpod.dev/
- `image_picker`: https://pub.dev/packages/image_picker
- `path_provider`: https://pub.dev/packages/path_provider
- `json_serializable`: https://pub.dev/packages/json_serializable
- Política de uso de teselas de OpenStreetMap: https://operations.osmfoundation.org/policies/tiles/
- Atribución y derechos de OpenStreetMap: https://www.openstreetmap.org/copyright

