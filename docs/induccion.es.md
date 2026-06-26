<!-- Versión fuente: 2026-06-26 -->
# Guía de Inducción: Framework de Documentación en Confluence

Bienvenido al equipo. Esta guía es tu punto de entrada para entender cómo documentamos. En 10 minutos tendrás una visión completa del framework y sabrás cómo crear tu primera página.

---

## 1. ¿Qué es este framework y por qué existe?

Este framework estandariza cómo el equipo crea, organiza y mantiene la documentación técnica en Confluence Cloud.

**El problema que resuelve:**
- Documentación dispersa entre Excel, Word, PDFs y Confluence sin estructura
- Nadie sabe dónde encontrar la información que necesita
- Documentos desactualizados que generan confusión
- Cada persona documenta de forma diferente

**La filosofía en una frase:**

> **Confluence es para el conocimiento duradero. Enlaza, no dupliques.**

Esto significa:
- Si la información ya existe en Jira, Figma, Swagger o Git — **enlázala**, no la copies
- Si un documento ya no es vigente — **archívalo**, no lo dejes abandonado
- Si no sabes dónde va algo — **consulta la guía de decisión** antes de crear una página

---

## 2. Ruta de Aprendizaje

Lee las guías en este orden. Cada una construye sobre la anterior:

| Orden | Guía | Qué aprenderás | Tiempo estimado |
|:-----:|------|-----------------|:---------:|
| 1 | [Guía del Equipo](team-guide.es.md) | El flujo de trabajo diario: cómo crear, revisar y mantener páginas | 15 min |
| 2 | [Estructura del Espacio](space-structure.es.md) | Cómo está organizado el espacio de Confluence y dónde crear tus páginas | 10 min |
| 3 | [Guía de Decisión](decision-guide.es.md) | Qué va en Confluence vs. Jira, Figma, Git u otras herramientas | 10 min |
| 4 | [Guía de Estándares](documentation-guide.es.md) | Convenciones de nombrado, etiquetas, ciclo de vida y reglas de calidad | 15 min (referencia) |
| 5 | [Gobernanza](governance.es.md) | Roles, responsabilidades y cadencia de revisiones | 10 min |

**Consejo**: Las guías 1-3 son las más importantes para tu día a día. Las guías 4 y 5 son de referencia — consúltalas cuando necesites detalles específicos.

---

## 3. Tarjeta de Referencia Rápida

### Patrón de nombrado

```
[{PREFIX}-{SECCIÓN}] Tipo — Tema
```

Ejemplos:
- `[ACME-FRONT] Functional Specification — Contact Form`
- `[ACME-BACK] API Specification — Notification Service`
- `ADR-0015 — Selection of Database Engine for Sessions`
- `RB — Backend — 502 Error in API Gateway`

### Labels obligatorios (mínimo 3 por página)

| Label | Propósito | Ejemplo |
|-------|-----------|---------|
| `team:{equipo}` | Equipo responsable | `team:frontend` |
| `type:{tipo}` | Tipo de documento | `type:func-spec` |
| `status:{estado}` | Estado del ciclo de vida | `status:draft` |

### Ciclo de vida

```
DRAFT ──> IN-REVIEW ──> APPROVED ──> ARCHIVED / OBSOLETE
```

| Estado | Significado |
|--------|-------------|
| **DRAFT** | En progreso, aún no confiable |
| **IN-REVIEW** | Enviado a revisión, no modificar sin coordinación |
| **APPROVED** | Revisado y aprobado, fuente de verdad |
| **ARCHIVED** | Ya no vigente, preservado como referencia histórica |
| **OBSOLETE** | Reemplazado por otra versión, no usar |

### Secciones del espacio

| Tu dominio | Sección | Prefijo |
|------------|---------|---------|
| Frontend | Frontend | `{PREFIX}-FRONT` |
| Backend / APIs | Backend & Services | `{PREFIX}-BACK` |
| Diseño | UI/UX Design | `{PREFIX}-DESIGN` |
| Negocio / Producto | Business & Product | `{PREFIX}-BIZ` |
| Arquitectura / Cloud | Architecture & Cloud | `{PREFIX}-ARCH` |
| Seguridad | Security & Compliance | `{PREFIX}-SEC` |
| QA / Testing | QA & Testing | `{PREFIX}-QA` |
| Transversal | Governance Hub | `{PREFIX}-HUB` |

### Flujo de aprobación

```
Tú (autor)                    Revisor                     Aprobador
    |                            |                            |
    +-- Crear página DRAFT       |                            |
    +-- Cambiar a IN-REVIEW ---->|                            |
    |                            +-- Revisar                  |
    |                            +-- Dejar comentarios inline |
    |<-- Comentarios ------------+                            |
    +-- Resolver comentarios     |                            |
    +-- Notificar ---------------+>                           |
    |                            +-- OK ---------------------->|
    |                            |                            +-- Aprobar
    |                            |                            +-- Cambiar a APPROVED
    |<------------------------------------------------------------+
    +-- Hecho                                                 |
```

### Tipos de documento disponibles

| Tipo | Cuándo usarlo | Template key |
|------|---------------|:------------:|
| Especificación Funcional | Documentar una funcionalidad (AS-IS o TO-BE) | `func-spec` |
| ADR | Registrar una decisión técnica importante | `adr` |
| Especificación de API | Documentar una API (complemento de Swagger) | `api-spec` |
| Configuración de Entorno | Documentar configs de DEV/QA/STG/PROD | `env-config` |
| Runbook | Procedimiento para resolver incidentes | `runbook` |
| Documento de Seguridad | Políticas SDLC, cumplimiento, auditorías | `security-doc` |
| Documento de Migración | Plan de transición AS-IS a TO-BE | `migration` |
| Plan de Pruebas | Planificar un ciclo de pruebas | `test-plan` |
| Estrategia de Pruebas | Estrategia global de QA | `test-strategy` |
| Solicitud de Infraestructura | Solicitar un componente cloud | `infra-request` |
| Solicitud de Rol | Solicitar un rol IAM/RBAC | `role-request` |

---

## 4. Ejemplo Práctico: Crear una Especificación Funcional

Escenario: eres parte del equipo de Frontend y necesitas documentar la funcionalidad "Formulario de Contacto".

### Paso 1: Crea la página

- Ve al espacio `ACMEWEB` en Confluence
- Navega a la sección **Frontend > Functional Documentation**
- Haz clic en **Create** (+) y selecciona la plantilla **Functional Specification**

### Paso 2: Establece el título

```
[ACME-FRONT] Functional Specification — Contact Form
```

### Paso 3: Rellena las Page Properties

| Field | Valor de ejemplo |
|-------|-----------------|
| **Status** | DRAFT |
| **Owner** | @tu.nombre |
| **Approver** | @tech.lead.frontend |
| **Last Review** | 2026-06-26 |
| **Next Review** | 2026-09-26 |
| **Version** | 1.0 |
| **Phase** | TO-BE |
| **Jira Epic** | ACME-1234 |

### Paso 4: Aplica los labels

```
team:frontend    type:func-spec    status:draft    phase:to-be    tech:nextjs
```

### Paso 5: Escribe el contenido

Sigue las secciones de la plantilla en orden:

1. **General Description** — Breve descripción del formulario de contacto (2-3 oraciones)
2. **Business Context** — Por qué existe esta funcionalidad
3. **Scope** — Qué incluye y qué no
4. **Current State (AS-IS)** — Si existe algo previo, descríbelo. Si es nuevo: "No aplica — funcionalidad nueva"
5. **Target State (TO-BE)** — Describe el flujo objetivo. Inserta un diagrama con la macro draw.io
6. **Functional Requirements** — Tabla con los requisitos (FR-001, FR-002, etc.)
7. **Business Rules** — Lista de reglas de negocio (BR-001, BR-002, etc.)
8. **Data Requirements** — Campos, tipos, validaciones
9. **Integration Points** — Sistemas con los que se integra
10. **Non-Functional Requirements** — Performance, seguridad, accesibilidad
11. **Open Questions** — Dudas pendientes con responsable asignado
12. **Change History** — Registro de cambios

### Paso 6: Cambia el Content State a DRAFT

En la parte superior de la página, haz clic en la insignia de estado y selecciona **DRAFT**.

### Paso 7: Publica y notifica

1. Haz clic en **Publish**
2. Menciona a tu revisor con **@nombre** en un comentario
3. Enlaza la página en el epic de Jira correspondiente

---

## 5. Checklist de Publicación

Usa esta lista cada vez que crees o actualices una página:

- [ ] **Título** sigue el patrón `[PREFIX-SECCIÓN] Tipo — Tema`
- [ ] **Page Properties** completo con todos los campos obligatorios (Status, Owner, Approver, Last Review, Next Review, Version)
- [ ] **Labels obligatorios** aplicados: al menos `team:`, `type:`, `status:`
- [ ] **Labels condicionales** aplicados si corresponde: `phase:`, `env:`, `compliance:`
- [ ] **Content State** configurado (DRAFT al crear, IN-REVIEW al enviar a revisión)
- [ ] **Sección correcta** del espacio (Frontend en Frontend, Backend en Backend, etc.)
- [ ] **Estructura de la plantilla** respetada (no se añadieron ni eliminaron secciones)
- [ ] **Diagramas** con la macro draw.io (no imágenes estáticas)
- [ ] **Sin secretos** ni credenciales en la página (usar referencia al gestor de secretos)
- [ ] **Enlaces** a Jira/Figma/Swagger en lugar de duplicar contenido
- [ ] **Historial de cambios** actualizado al final de la página
- [ ] **Revisor notificado** con @mención en un comentario

---

## Preguntas Frecuentes

**¿En qué idioma escribo la documentación?**
En el idioma configurado en el `project-config.md` de tu proyecto. Los labels, prefijos de título y campos de Page Properties siempre van en inglés.

**¿Qué hago si no encuentro una plantilla para lo que necesito documentar?**
Consulta la [Guía de Decisión](decision-guide.es.md). Si el contenido no pertenece a Confluence, documéntalo en la herramienta correcta y enlázalo. Si sí pertenece a Confluence pero no hay plantilla, habla con el Documentation Champion.

**¿Puedo crear una página sin usar una plantilla?**
No para los tipos de documento estándar. Las plantillas aseguran consistencia y permiten que la IA procese los documentos. Si necesitas una página libre (notas de reunión, lecciones aprendidas), puede ser más informal, pero siempre necesita los 3 labels obligatorios.

**¿Cada cuánto debo revisar mis documentos?**
- Documentos normales: cada 3 meses
- Configuraciones de entorno: cada mes
- Runbooks: después de cada incidente donde se usaron

**¿Qué pasa si encuentro un documento desactualizado de otra persona?**
Notifica al Owner que aparece en las Page Properties. Si no hay Owner asignado, notifica al Section Owner de esa sección.
