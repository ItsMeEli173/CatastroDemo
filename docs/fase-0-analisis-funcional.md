# CatastroDemo — Fase 0: análisis funcional y definición del dominio

Documento derivado de `CatastroDemo-Requerimientos.md` v1.0. Cierra requisitos, reglas y casos de uso antes de implementar.

## 1. Actores y escenarios

| Actor | Escenario principal |
|---|---|
| Técnico de campo | Registra agricultores y parcelas durante una visita, captura vértices con GPS y adjunta fotografías. |
| Responsable de datos | Consulta y corrige información, administra variedades, temporadas y unidades, y genera respaldos. |
| Instalación local | Única fuente de datos: SQLite privado del dispositivo. No hay cuentas, roles ni sincronización. |

Escenarios: alta de agricultor; alta de parcela con propietarios; delimitación de parcela en campo sin conexión; consulta posterior con mapa; distribución de variedades; estimación de cosecha; respaldo JSON/ZIP.

## 2. Glosario

- **Agricultor (`Farmer`)**: persona física registrada; puede ser propietario de varias parcelas.
- **Parcela (`Parcel`)**: unidad territorial identificada por un código único; contiene propietarios, vértices, variedades y estimaciones.
- **Propietario (`ParcelOwner`)**: asociación agricultor–parcela con participación porcentual opcional.
- **Vértice (`ParcelVertex`)**: punto WGS84 del límite, ordenado por `sequence_number`; origen GPS o manual.
- **Fotografía de vértice (`VertexPhoto`)**: archivo JPG/PNG en almacenamiento privado con metadatos en SQLite.
- **Variedad (`GrapeVariety`)**: cultivar de vid del catálogo editable.
- **Distribución de variedades (`ParcelVariety`)**: porcentaje de **superficie** de la parcela ocupado por una variedad.
- **Temporada (`HarvestSeason`)**: campaña agrícola con nombre y fechas opcionales.
- **Unidad (`MeasurementUnit`)**: unidad de registro con equivalencia en kg cuando es fija (ej. `kg`, `crate`, `ton`).
- **Estimación (`ProductionEstimate`)**: cantidad registrada × factor de conversión, guardada con el factor histórico.
- **Superficie declarada**: dato ingresado por el agricultor. **Superficie calculada**: derivada de los vértices (excedente esférico). Nunca se sustituyen entre sí.
- **Borrador**: parcela en estado `draft` con datos incompletos admitidos (porcentajes sin totalizar, geometría sin cerrar).

## 3. Casos de uso

| ID | Caso de uso | Resultado |
|---|---|---|
| CU-01 | Registrar/editar/buscar/eliminar agricultor | Agricultor persistido; eliminación bloqueada si tiene parcelas asociadas. |
| CU-02 | Asociar propietarios a una parcela | Asociaciones únicas por (parcela, agricultor) con participación opcional. |
| CU-03 | Crear parcela | Código único; estado `draft` o `active`; superficie declarada opcional. |
| CU-04 | Delimitar parcela | Vértices capturados/ordenados/editados; polígono validado; área calculada. |
| CU-05 | Consultar parcela en mapa | Polígono y marcadores sobre OSM; sin red se conservan geometría y datos. |
| CU-06 | Administrar variedades | Catálogo local con búsqueda y desactivación sin pérdida de historial. |
| CU-07 | Distribuir variedades en parcela | Porcentajes por variedad con advertencia de suma y superficies aproximadas. |
| CU-08 | Definir temporadas y unidades | Temporadas históricas y factores de conversión configurables. |
| CU-09 | Registrar estimación | Estimación general o por variedad con kg calculados y factor guardado. |
| CU-10 | Consultar producción | Resumen por parcela/temporada sin doble conteo. |
| CU-11 | Adjuntar fotografía a vértice | Archivo privado + metadatos; miniatura y previsualización. |
| CU-12 | Exportar JSON / respaldo ZIP | Archivos compartibles con datos consistentes; no mutan datos. |
| CU-13 | Consultar panel inicial | Conteos de agricultores y parcelas y accesos rápidos. |

## 4. Reglas de negocio

**Agricultores**
- RN-01 `first_name` y `last_name` obligatorios (no vacíos, ≤120 caracteres). Documento, teléfono, correo, localidad, dirección y notas opcionales.
- RN-02 El correo, si existe, debe tener formato válido; el teléfono solo admite dígitos, espacios, `+`, `-` y paréntesis.
- RN-03 Eliminar un agricultor con asociaciones de propiedad activas se rechaza con un mensaje explícito; primero se eliminan las asociaciones.

**Propietarios**
- RN-04 No se duplica la asociación (parcela, agricultor).
- RN-05 `ownership_percentage` ∈ [0, 100] si se informa. Si **todas** las asociaciones informan porcentaje y la suma no es 100 %, se muestra advertencia y se exige confirmación para guardar; nunca se corrige automáticamente.
- RN-06 Si falta algún porcentaje, la suma no se evalúa como error (borrador informativo).
- RN-07 La participación de propietarios y la distribución de variedades son campos, tablas y pantallas independientes.

**Parcelas**
- RN-08 `code` obligatorio y único (≤40 caracteres); `name` opcional.
- RN-09 `declared_area_m2` ≥ 0 y opcional; `calculated_area_m2` solo se deriva de los vértices y se etiqueta como aproximada.
- RN-10 La superficie calculada se recalcula en la misma transacción que crea, edita o elimina vértices.
- RN-11 `status` ∈ {`draft`, `active`, `inactive`}. Una parcela `active` exige al menos tres vértices y polígono válido; `draft` admite geometría incompleta.
- RN-12 Eliminar una parcela elimina en cascada propietarios, vértices, fotografías (filas y archivos), variedades y estimaciones, previa confirmación.

**Geometría**
- RN-13 Coordenadas WGS84: latitud ∈ [-90, 90], longitud ∈ [-180, 180].
- RN-14 Se requieren al menos tres vértices distintos y no consecutivos duplicados (incluido último–primero).
- RN-15 Se rechaza autointersección de aristas no adyacentes y área calculada nula o menor a 1 m².
- RN-16 El cierre del polígono es implícito al representar; no se duplica el primer vértice.
- RN-17 `sequence_number` es consecutivo desde 0 y único por parcela; reordenar renumerar en una transacción.
- RN-18 El área se calcula con excedente esférico (radio medio 6 371 008,8 m), no con distancias sumadas ni grados cartesianos. Error típico < 0,1 % en parcelas de hasta pocos kilómetros; no es levantamiento topográfico.

**Variedades**
- RN-19 `name` obligatorio y único (sin distinguir mayúsculas); `active` controla la selección en nuevos registros sin romper historial.
- RN-20 `planted_area_percentage` ∈ [0, 100]; duplicado de variedad en la misma parcela rechazado; suma ≠ 100 % advertida con confirmación, nunca corregida automáticamente.
- RN-21 La superficie aproximada por variedad usa superficie calculada y, si no existe, la declarada; se etiqueta el origen.

**Producción**
- RN-22 `quantity` > 0; no se admiten cero ni negativos. `conversion_factor_kg` > 0 guardado en cada estimación.
- RN-23 `estimated_kg = quantity × factor` redondeado a 2 decimales al presentar; se conserva el valor completo.
- RN-24 Cambiar la equivalencia de una unidad no altera estimaciones existentes.
- RN-25 Un resumen elige **un** modo: general (solo `grape_variety_id` nulo) o desglose por variedad. Nunca suma ambos.
- RN-26 Una temporada no sobrescribe otra; el nombre es único.

**Fotografías**
- RN-27 Nombre único `photo_<uuid>.<ext>`; ruta relativa `photos/<nombre>` en SQLite; nunca rutas absolutas.
- RN-28 El archivo inexistente o dañado se muestra como no disponible y no bloquea el vértice ni la parcela.
- RN-29 Eliminar un vértice elimina sus fotografías tras confirmación; los archivos huérfanos se detectan y depuran desde mantenimiento.
- RN-30 La interfaz de la demo muestra una fotografía por vértice; el modelo admite varias.

**Exportación**
- RN-31 JSON con `schema_version` `1.0`, `app_name`, `exported_at` UTC ISO 8601 y arreglos de todas las entidades.
- RN-32 La lectura se ejecuta en una transacción consistente; no muta datos.
- RN-33 ZIP `CatastroDemo_backup_YYYYMMDD.zip` con `manifest.json`, `data.json` y `photos/` disponibles.
- RN-34 Sin credenciales, secretos ni rutas absolutas.

## 5. Modelo entidad-relación conceptual

```text
farmers 1 ──< parcel_owners >── 1 parcels
parcels 1 ──< parcel_vertices 1 ──< vertex_photos
parcels 1 ──< parcel_varieties >── 1 grape_varieties
parcels 1 ──< production_estimates >── 1 harvest_seasons
production_estimates >── 1 measurement_units
production_estimates >── 0..1 grape_varieties
```

Cardinalidades: agricultor N:M parcela (resuelta por `parcel_owners`); parcela 1:N vértices ordenados; vértice 1:N fotografías; parcela N:M variedad (resuelta por `parcel_varieties`); parcela 1:N estimaciones; temporada 1:N estimaciones; unidad 1:N estimaciones.

## 6. Flujos de navegación

```text
Inicio
├── Agricultores ─ listado/búsqueda ─ detalle ─ formulario ─ parcelas asociadas
├── Parcelas ─ listado/búsqueda ─ detalle
│   ├── Datos generales / superficie declarada vs calculada
│   ├── Propietarios (participación %)
│   ├── Vértices (orden, GPS/manual, fotos) ─ mapa (OSM, ubicación, polígono)
│   ├── Variedades (porcentaje de superficie)
│   └── Producción (temporada, unidad, kg)
├── Variedades ─ catálogo/búsqueda ─ formulario
├── Producción ─ temporadas / unidades / resumen
└── Exportación ─ JSON / ZIP ─ compartir
```

Reglas de navegación: confirmación antes de operaciones destructivas; mapa con atribución visible y aviso cuando faltan teselas; indicadores de precisión GPS; mensajes de error explícitos.

## 7. Matriz de validaciones

| Campo / operación | Obligatorio | Regla | Momento | Mensaje (es) |
|---|---|---|---|---|
| Agricultor: nombres/apellidos | Sí | solo letras (incluye acentos y `Ñ`) y espacios internos; sin espacios al inicio/fin; ≤120 | formulario + entidad + BD | "Ingresa los nombres." / "Ingresa los apellidos." |
| Agricultor: correo | No | formato de correo | formulario | "Ingresa un correo válido." |
| Agricultor: teléfono | No | 6–25, solo `+`, dígitos, espacio, `-`, `()` | formulario | "Ingresa un teléfono válido." |
| Agricultor: eliminar con parcelas | — | bloqueado | diálogo + repositorio | "No se puede eliminar: tiene parcelas asociadas." |
| Códigos de registro (agricultor, parcela, variedad, unidad, temporada) | — | autogenerado y único; de solo lectura | repositorio + BD | — |
| Agricultor: documento/CI | No | libre | formulario | — |
| Parcela: código | — | autogenerado `PAR-###`, único, solo lectura | repositorio + BD | — |
| Parcela: superficie declarada | No | ≥ 0 | formulario | "La superficie declarada no puede ser negativa." |
| Parcela activa | — | ≥3 vértices y polígono válido | guardar/activar | "Una parcela activa necesita al menos 3 vértices válidos." |
| Propietario: porcentaje | No | 0–100 | formulario + BD | "El porcentaje debe estar entre 0 y 100." |
| Propietarios: suma | No | advertencia ≠100 | guardar | "La suma de participaciones es X %. ¿Deseas guardar igualmente?" |
| Propietario: duplicado | — | único | repositorio | "Ese agricultor ya es propietario de la parcela." |
| Vértice: coordenadas | Sí | rangos WGS84 | editor + BD | "Coordenada fuera de rango." |
| Vértice: duplicados | — | consecutivos y cierre | editor | "Hay vértices consecutivos repetidos." |
| Polígono: mínimo | — | ≥3 distintos | editor/activar | "Se necesitan al menos 3 vértices." |
| Polígono: autointersección | — | ninguna arista no adyacente se cruza | editor | "El polígono se cruza consigo mismo." |
| Polígono: área | — | ≥ 1 m² | editor | "La superficie del polígono es nula o inválida." |
| Variedad: nombre | Sí | ≤80, único (ci) | formulario + BD | "Ingresa el nombre de la variedad." / "Ya existe una variedad con ese nombre." |
| Variedad: porcentaje | No | 0–100 | formulario | "El porcentaje debe estar entre 0 y 100." |
| Variedades: suma | No | advertencia ≠100 | guardar | "La suma de superficies por variedad es X %." |
| Estimación: cantidad | Sí | > 0 | formulario + BD | "Ingresa una cantidad mayor a cero." |
| Estimación: factor | Sí | > 0 | formulario + BD | "El factor de conversión debe ser mayor a cero." |
| Temporada: nombre | Sí | único | formulario + BD | "Ingresa el nombre de la temporada." |
| Unidad: abreviatura | Sí | única | formulario + BD | "Ingresa la abreviatura de la unidad." / "Ya existe una unidad con esa abreviatura." |
| Exportación | — | informar éxito/fallo | acción | "Exportación completada." / "No se pudo exportar." |

## 8. Requisitos no funcionales

- RNF-01 Offline: todas las operaciones CRUD funcionan sin red; solo las teselas OSM requieren conexión.
- RNF-02 Rendimiento: listados con miles de filas paginados por consulta indexada; sin bloqueo del hilo de UI en exportaciones (compute/isolate si es necesario).
- RNF-03 Integridad: claves foráneas activas, transacciones en operaciones multi-tabla, índices en búsquedas y claves foráneas.
- RNF-04 Seguridad local: almacenamiento privado de la app; sin secretos embebidos; sin rutas absolutas exportadas.
- RNF-05 Usabilidad de campo: controles ≥48 dp, alto contraste, mensajes en español, confirmaciones destructivas.
- RNF-06 Mantenibilidad: SOLID, dominio puro, repositorios por interfaz, pruebas junto al código.
- RNF-07 Portabilidad: Android como objetivo de demo; iOS configurado con permisos equivalentes.

## 9. Decisiones cerradas en Fase 0

| Decisión pendiente del documento | Resolución |
|---|---|
| Plataforma de demo | Android (APK); iOS configurado, no compilado en este entorno Windows. |
| Campos de agricultor | Los propuestos, todos opcionales salvo nombres y apellidos. |
| Participación de propietarios | Opcional e informativa, con advertencia de suma ≠ 100 %. |
| Superficies | Aproximadas; declarada y calculada separadas; sin reglas catastrales. |
| Cajones | Factor configurable por estimación, precargado desde la unidad si existe. |
| Variedades iniciales | Moscatel de Alejandría, Malbec, Cabernet Sauvignon, Syrah (semilla editable). |
| Fotografías por vértice | Interfaz limitada a una; modelo admite N. |
| Superposiciones | Fuera de la demo; documentado como mejora secundaria. |
| Borradores | Parcelas `draft` admiten geometría y porcentajes incompletos. |
