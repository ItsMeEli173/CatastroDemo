---
name: gitflow
description: "Trigger: rama, branch, gitflow, push, merge, PR, feature, release, bugfix, hotfix, dev, sqa, main. Apply standard gitflow branch policy for repository workflows."
license: Apache-2.0
metadata:
  author: "Elias"
  version: "1.0"
---

# Gitflow Workflow

## Contrato de activación

Aplicar a toda creación de rama, push, merge, PR y operación de release en este repositorio. Verificar siempre el nombre de la rama, la rama destino y la autorización requerida antes de cualquier operación de Git.

## Reglas duras

- Ramas fijas: `main`, `qa` (o `sqa`), `dev`. Nunca eliminarlas ni renombrarlas.
- Ramas temporales: `feature`, `release`, `bugfix`, `hotfix`. Siempre eliminarlas después del merge.
- Los nombres de rama DEBEN ser cortos y SIEMPRE con el prefijo del tipo de rama y su número correspondiente: `feature/12-nombre-corto` (nunca `feature/cosas-varias-de-login-con-jwt-y-mas`).
- `main`: solo push con autorización explícita o instrucción específica del usuario. Nunca hacer push directo.
- `qa`/`sqa`: solo push cuando las pruebas automatizadas pasen.
- `dev`: push después de implementar cada cambio.
- Los merges deben seguir la ruta de promoción; nunca fusionar una rama temporal directamente en `main`.

## Puertas de decisión

| Situación | Crear rama | Fusionar en |
|---|---|---|
| Nueva funcionalidad | `feature/<num>-<slug>` | `dev` |
| Integración verificada por pruebas | `dev` | `qa` / `sqa` |
| Candidato a release | `release/<num>-<slug>` | `qa` / `sqa` y luego `main` |
| Defecto en una funcionalidad existente | `bugfix/<num>-<slug>` | `dev` |
| Incidente de producción | `hotfix/<num>-<slug>` | `main` (con autorización) |

## Pasos de ejecución

1. Identificar el tipo de rama según la tabla de decisiones.
2. Crear la rama desde la base correcta: `feature`/`bugfix` desde `dev`; `hotfix`/`release` desde `main`.
3. Nombrarla con el prefijo del tipo + número + slug corto (`feature/12-nombre-corto`).
4. Hacer commits con conventional commits acotados a esa rama, con el **mensaje en español**.
5. Push según la puerta: después de implementar cada cambio → `dev`; después de pasar las pruebas → `qa` / `sqa`; solo con autorización explícita → `main`.
6. Después del merge, eliminar la rama temporal.

## Contrato de salida

Devolver: el nombre exacto de la rama creada, su base, el destino del PR/merge y qué puerta autorizó el push (`dev` / `qa` / `main` con autorización). Si falta la puerta, DETENERSE y reportar cuál falta; nunca hacer push.
