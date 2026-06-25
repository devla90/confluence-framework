<!-- Versión fuente: 2026-06-25 -->
# Guía de Estándares de Documentación

Esta guía define cómo se escribe, nombra, etiqueta y mantiene la documentación en Confluence para el proyecto.

---

## 1. Convenciones de Nomenclatura

### Títulos de Página

Los títulos deben ser **globalmente únicos** (no solo dentro del espacio) para facilitar la búsqueda y el enlazado.

| Tipo de documento | Patrón | Ejemplo |
|---------------|---------|---------|
| Documentación general | `[PROJ-XXX] Type — Subject` | `[PROJ-FRONT] Functional Specification — Contact Form` |
| ADR | `ADR-NNNN — Decision Title` | `ADR-0012 — Selection of Framework X over Framework Y` |
| Runbook | `RB — System — Scenario` | `RB — Frontend — CDN Cache Invalidation` |
| Release Notes | `RN YYYY-MM-DD — vX.Y.Z` | `RN 2026-06-15 — v2.1.0` |
| Solicitud de Despliegue | `DR YYYY-MM-DD — Description` | `DR 2026-06-10 — Deploy Service Forms` |
| Configuración de Entorno | `ENV-{ENVIRONMENT} — Technology/Component` | `ENV-PROD — Web Application` |
| Documento de Migración | `MIG — Subject — AS-IS to TO-BE` | `MIG — Contact Module — AS-IS to TO-BE` |
| Solicitud de Infraestructura | `[PROJ-ARCH] Infra Request — Description` | `[PROJ-ARCH] Infra Request — S3 Bucket Production Assets` |
| Solicitud de Rol de Despliegue | `[PROJ-ARCH] Role Request — Role Name` | `[PROJ-ARCH] Role Request — Lambda Deploy Role` |

### Adjuntos

Para documentos migrados desde Excel, PDF o Word:

```
{PROJ-XXX}_{DocType}_{Subject}_{YYYY-MM-DD}_v{N}.{ext}
```

Ejemplo: `PROJ-BACK_FuncSpec_FormService_2026-06-01_v2.pdf`

### Nota sobre Prefijos y Configuración de Espacio Único

Los prefijos como `PROJ-FRONT`, `PROJ-BACK`, etc. identifican la sección de dominio en el título de la página. En una configuración de espacio único, todas las páginas viven en el espacio `{SPACE_KEY}`. Si las secciones se separan posteriormente en sus propios espacios, los títulos no requieren cambios — están preparados para la migración.

### Por Qué Importa para la IA

Los títulos predecibles y autocontenidos permiten que un sistema RAG identifique el propósito del documento solo a partir del título, mejorando la precisión de recuperación sin necesidad de leer el contenido completo.

---

## 2. Taxonomía de Etiquetas

Las etiquetas en Confluence Cloud son planas (sin jerarquía). Usamos **prefijos con namespace** para crear estructura.

### Categorías de Etiquetas

| Prefijo | Propósito | Valores |
|--------|---------|--------|
| `team:` | Equipo responsable | Define las etiquetas `team:` específicas del proyecto en tu `project-config.md`. Patrón: `team:{team-label}` (p. ej., `team:frontend`, `team:backend`, `team:design`, `team:business`, `team:architecture`, `team:security`, `team:qa`) |
| `type:` | Tipo de documento | `type:func-spec`, `type:adr`, `type:runbook`, `type:api-spec`, `type:env-config`, `type:release-note`, `type:deployment-request`, `type:guide`, `type:policy`, `type:migration`, `type:test-plan`, `type:test-strategy`, `type:infra-request`, `type:role-request` |
| `status:` | Estado del ciclo de vida | `status:draft`, `status:in-review`, `status:approved`, `status:archived`, `status:obsolete` |
| `phase:` | Fase del sistema | `phase:as-is`, `phase:to-be`, `phase:transition` |
| `env:` | Entorno | `env:dev`, `env:qa`, `env:stg`, `env:prod`, `env:all` |
| `tech:` | Tecnología | Define las etiquetas `tech:` específicas del proyecto en tu `project-config.md`. Patrón: `tech:{technology}` (p. ej., `tech:framework-x`, `tech:database-y`, `tech:service-z`) |
| `compliance:` | Regulatorio/auditoría | `compliance:sdlc-security`, `compliance:gdpr`, `compliance:audit-required`, `compliance:pci` |
| `ai:` | Metadatos de procesamiento de IA | `ai:template-compliant`, `ai:needs-structuring`, `ai:auto-generated`, `ai:reviewed` |

### Reglas de Etiquetado Obligatorias

**Cada página debe tener como mínimo:**
1. Una etiqueta `team:`
2. Una etiqueta `type:`
3. Una etiqueta `status:`

**Etiquetas obligatorias adicionales según el contexto:**
- Documentos funcionales y de flujo: agregar `phase:` (as-is, to-be o transition)
- Documentos de entorno: agregar `env:`
- Documentos de seguridad/cumplimiento: agregar `compliance:`
- Páginas que siguen la plantilla estructurada: agregar `ai:template-compliant`

### Lista Cerrada de Etiquetas

Mantén una lista cerrada en la página **{PREFIX}-HUB / Documentation Standards / Label Taxonomy**. Los autores deben usar únicamente etiquetas de esta lista. Si necesitan una nueva, deben solicitarla al Documentation Champion para mantener la consistencia.

---

## 3. Ciclo de Vida del Documento

### Estados

```
DRAFT ──> IN-REVIEW ──> APPROVED ──> ARCHIVED
  ^           |              |            |
  |           |              |            v
  └───────────┘              |        OBSOLETE
     (revisiones)            |
                             v
                        (nueva versión)
```

### Uso de Content States en Confluence Cloud

Confluence Cloud tiene **Content States** nativos. Configura los siguientes estados personalizados en la configuración del espacio:

| Content State | Color sugerido | Significado |
|---------------|----------------|---------|
| DRAFT | Gris | Documento en progreso, aún no confiable |
| IN-REVIEW | Amarillo | Enviado a revisión, no modificar sin coordinación |
| APPROVED | Verde | Revisado y aprobado, fuente de verdad |
| ARCHIVED | Azul | Ya no vigente pero preservado como referencia histórica |
| OBSOLETE | Rojo | Reemplazado por otra versión, no usar |

### Transiciones

| Desde | Hacia | Quién | Cuándo |
|------|----|-----|------|
| DRAFT | IN-REVIEW | Autor | Cuando considera que el documento está completo |
| IN-REVIEW | DRAFT | Revisor | Si se requieren cambios significativos |
| IN-REVIEW | APPROVED | Aprobador | Tras una revisión satisfactoria |
| APPROVED | DRAFT | Autor | Cuando se necesita una actualización mayor (crea una nueva versión) |
| APPROVED | ARCHIVED | Space Owner | Cuando es reemplazado por una versión más reciente |
| APPROVED | OBSOLETE | Space Owner | Cuando el tema ya no aplica (p. ej., componente AS-IS dado de baja) |

---

## 4. Page Properties (Metadatos Estructurados)

Cada página debe incluir una tabla de **Page Properties** en la parte superior usando la macro de Confluence. Esta tabla constituye los metadatos legibles por máquina del documento.

### Campos Estándar

| Campo | Requerido | Descripción |
|-------|----------|-------------|
| Status | Sí | DRAFT / IN-REVIEW / APPROVED / ARCHIVED / OBSOLETE |
| Owner | Sí | Propietario del documento (mencionar @user) |
| Approver | Sí | Quién aprueba el documento |
| Last Review | Sí | Fecha de la última revisión (YYYY-MM-DD) |
| Next Review | Sí | Fecha programada para la próxima revisión |
| Version | Sí | Número de versión del contenido (1.0, 1.1, 2.0...) |
| Phase | Condicional | AS-IS / TO-BE / Transition (solo para documentos funcionales) |
| Related Jira Epic | Opcional | Enlace mediante la macro de Jira al epic asociado |
| Environment | Condicional | DEV / QA / STG / PROD (solo para documentos de configuración) |

### Ejemplo de Page Properties

```
┌─────────────────────────────────────────────────┐
│ Page Properties (Confluence macro)               │
│                                                  │
│ Status:            APPROVED                      │
│ Owner:             @maria.garcia                 │
│ Approver:          @carlos.lopez                 │
│ Last Reviewed:     2026-06-01                    │
│ Next Review:       2026-09-01                    │
│ Version:           2.0                           │
│ Phase:             TO-BE                         │
│ Jira Epic:         PROJ-1234                     │
└─────────────────────────────────────────────────┘
```

### Page Properties Report

En las páginas índice (como "Service Catalog" o "Functional Documentation"), usa la macro **Page Properties Report** para generar tablas automáticas que agregan los metadatos de las páginas hijas. Esto crea dashboards en vivo.

---

## 5. Reglas de Redacción

### Principios

1. **Conciso y escaneable**: Usa listas, tablas y secciones numeradas. Evita los párrafos largos.
2. **Secciones numeradas y consistentes**: Sigue la plantilla correspondiente al tipo de documento.
3. **Enlaza, no dupliques**: Si la información existe en Jira, Figma, Swagger o Git, enlázala. No copies contenido que quedará desactualizado.
4. **Diagramas editables**: Usa la macro de draw.io para los diagramas (no imágenes estáticas). Si se importa una imagen, debe ser temporal y reemplazarse por un diagrama editable.
5. **Sin secretos ni credenciales**: Nunca incluyas contraseñas, API keys, tokens ni datos sensibles. Referencia la ruta en tu gestor de secretos (p. ej., AWS Secrets Manager, HashiCorp Vault).
6. **Tablas para datos estructurados**: Requisitos, reglas de negocio, parámetros de configuración — siempre en una tabla con columnas claras.

### Formato

- **Encabezados**: H1 es solo para el título de la página (automático). Usa H2 para las secciones principales y H3 para las subsecciones.
- **Macros útiles**: Page Properties, Table of Children, Jira Issues, Status macro (para badges visuales), Expand (para contenido opcional), paneles Info/Warning/Note.
- **Embeds de diseño**: Usa la macro nativa de Figma Embed para mostrar diseños. No subas capturas de pantalla de herramientas de diseño.

---

## 6. Consultas CQL Útiles

Confluence Query Language (CQL) permite búsquedas potentes. Estas consultas pueden guardarse como favoritas o usarse en macros de Content Report.

### Búsquedas Operativas

```sql
-- All drafts from the backend team (within the space)
space = "{SPACE_KEY}" AND label = "team:backend" AND label = "status:draft"

-- Functional specifications TO-BE in review
label = "type:func-spec" AND label = "phase:to-be" AND label = "status:in-review"

-- Compliance docs that are still drafts (risk)
label = "compliance:audit-required" AND label = "status:draft"

-- Production configurations
label = "type:env-config" AND label = "env:prod"

-- All deployment requests
label = "type:deployment-request" ORDER BY created DESC

-- AS-IS documents marked as obsolete
label = "phase:as-is" AND label = "status:obsolete"

-- Pending infrastructure requests
label = "type:infra-request" AND label = "status:draft" ORDER BY created DESC

-- Deployment role requests
label = "type:role-request" ORDER BY created DESC
```

### Búsquedas de Mantenimiento

```sql
-- Approved documents not updated in 90+ days (potentially stale)
label = "status:approved" AND lastModified < now("-90d")

-- Pages without team label (incomplete)
space = "{SPACE_KEY}" AND label NOT IN ("team:frontend")

-- AI-generated documents pending human review
label = "ai:auto-generated" AND label NOT IN ("ai:reviewed")
```

### Búsquedas del Pipeline de IA

```sql
-- Documents ready for RAG ingestion
label = "ai:template-compliant" AND label = "status:approved"

-- Documents that need restructuring for AI
label = "ai:needs-structuring"
```

---

## 7. Migración de Documentos Existentes (Excel, PDF, Word)

### Proceso de Migración

1. **Evaluar**: Determina si el documento es AS-IS (quedará obsoleto) o TO-BE (activo).
2. **Decidir**: Si es AS-IS y se dará de baja pronto, puede permanecer como adjunto sin migrar el contenido. Si está activo o es TO-BE, migrarlo.
3. **Migrar contenido**: Crea una página de Confluence usando la plantilla apropiada. Copia/adapta el contenido al formato de Confluence.
4. **Adjuntar original**: Sube el archivo original como adjunto de la página con una nota: "Archivo original migrado el YYYY-MM-DD. El contenido de esta página de Confluence es la fuente de verdad."
5. **Etiquetar**: Aplica todas las etiquetas correspondientes, incluyendo `phase:` según aplique.
6. **Notificar**: Informa al equipo que el documento ha sido migrado y que el archivo original ya no debe editarse.

### Prioridad de Migración

| Prioridad | Criterio |
|----------|-----------|
| Alta | Documentos TO-BE en uso activo o en construcción |
| Media | Documentos transversales (configuraciones, integraciones) |
| Baja | Documentos AS-IS que quedarán obsoletos en < 3 meses |
| No migrar | Documentos puramente históricos sin valor operativo actual |

---

## 8. Referencia de Tipos de Documento

Fuente única de verdad para los tipos de documento, plantillas y etiquetas por defecto. Utilizada por el agente `confluence-doc` y la skill `/doc-confluence`.

| Type Key | Tipo de Documento | Plantilla | Etiquetas por Defecto |
|----------|--------------|----------|---------------|
| `func-spec` | Functional Specification | `templates/func-spec.md` | `type:func-spec`, `status:draft`, `team:{team}`, `phase:{phase}` |
| `adr` | Architecture Decision Record | `templates/adr.md` | `type:adr`, `status:draft`, `team:{team}` |
| `api-spec` | API Specification | `templates/api-spec.md` | `type:api-spec`, `status:draft`, `team:backend` |
| `env-config` | Environment Configuration | `templates/env-config.md` | `type:env-config`, `status:draft`, `team:{team}`, `env:{environment}` |
| `runbook` | Operational Runbook | `templates/runbook.md` | `type:runbook`, `status:draft`, `team:{team}` |
| `security-doc` | Security/Compliance Document | `templates/security-doc.md` | `type:policy`, `status:draft`, `team:security`, `compliance:{regulation}` |
| `migration` | Migration Document | `templates/migration.md` | `type:migration`, `status:draft`, `team:{team}`, `phase:transition` |
| `test-plan` | Test Plan | `templates/test-plan.md` | `type:test-plan`, `status:draft`, `team:qa` |
| `test-strategy` | Testing Strategy | `templates/test-strategy.md` | `type:test-strategy`, `status:draft`, `team:qa` |
| `infra-request` | Infrastructure Request | `templates/infra-request.md` | `type:infra-request`, `status:draft`, `team:architecture`, `env:{environment}` |
| `role-request` | Deployment Role Request | `templates/role-request.md` | `type:role-request`, `status:draft`, `team:architecture`, `env:{environment}` |

Reemplaza `{team}`, `{phase}`, `{environment}` y `{regulation}` con los valores reales del contexto de tu proyecto.

---

## 9. Estándares de Calidad de Documentos

Reglas para documentos de Confluence generados por IA y redactados manualmente. Referenciadas por el agente y la skill para evitar duplicación.

1. **Idioma**: Escribe en el idioma especificado en `project-config.md`. Por defecto, inglés si no se especifica.
2. **Sin invención**: Nunca inventes detalles técnicos, reglas de negocio ni requisitos. Solicita al autor o usuario la información faltante.
3. **Sin secretos**: Nunca incluyas contraseñas, API keys, tokens ni credenciales. Referencia la ruta de la plataforma de secretos definida en `project-config.md` (p. ej., "See AWS Secrets Manager: /prod/api/keys").
4. **Fidelidad a la plantilla**: Sigue la estructura de la plantilla exactamente — no agregues ni elimines secciones.
5. **Secciones numeradas**: Usa secciones numeradas que coincidan con la estructura de la plantilla.
6. **Datos estructurados**: Usa tablas para requisitos, configuraciones, reglas y parámetros.
7. **Placeholders**: Marca los campos sin completar con la sintaxis `{placeholder}` para que el autor sepa qué debe completar.
8. **Page Properties**: Incluye la tabla de Page Properties con todos los campos obligatorios (Status, Owner, Approver, Last Review, Next Review, Version).
9. **Changelog**: Incluye una entrada en la tabla de Changelog con la fecha de creación o modificación.
10. **Diagramas**: Indica dónde insertar las macros de draw.io — no uses imágenes estáticas.
11. **Referencias externas**: Para issue trackers, usa la macro apropiada (p. ej., Jira Issues). Para herramientas de diseño, usa la macro de embed (p. ej., Figma Embed). Enlaza, no dupliques.
