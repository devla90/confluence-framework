<!-- Versión fuente: 2026-06-25 -->
# Guía del Equipo: Cómo Documentamos en Confluence

Esta guía está dividida en dos partes:
- **Parte 1**: Cómo documentar manualmente (el flujo de trabajo diario del equipo)
- **Parte 2**: Cómo documentar con asistencia de IA (automatización progresiva)

---

# PARTE 1: Documentación Manual

## 1.1 Antes de crear una página

### Pregúntate: ¿Esto pertenece a Confluence?

Usa esta referencia rápida:

| Si tu contenido es... | Va en... | NO en Confluence |
|-----------------------|--------------|-------------------|
| Una historia de usuario o tarea | **Issue tracker** (p. ej., Jira) | No dupliques historias en Confluence |
| Un diseño visual o prototipo | **Herramienta de diseño** (p. ej., Figma) | Incrústalo en Confluence con el macro correspondiente, no subas capturas de pantalla |
| Código fuente | **Git** | No pegues bloques largos de código |
| Un secreto o credencial | **Gestor de secretos** (p. ej., AWS Secrets Manager, Vault) | **NUNCA** en Confluence |
| Especificación funcional, decisión técnica, guía, proceso | **Confluence** | Este es su lugar |

> **Regla de oro**: Si ya existe en otra herramienta, **enlaza, no dupliques**.

### Identifica el tipo de documento

| Tipo | Cuándo usarlo | Plantilla |
|------|------------|----------|
| Especificación Funcional | Documentar una funcionalidad (AS-IS o TO-BE) | `func-spec` |
| ADR | Registrar una decisión técnica importante | `adr` |
| Especificación de API | Documentar una API (complemento de Swagger/OpenAPI) | `api-spec` |
| Configuración de Entorno | Documentar configuraciones para DEV/QA/STG/PROD | `env-config` |
| Runbook | Crear un procedimiento para incidentes | `runbook` |
| Documento de Seguridad | Políticas SDLC, cumplimiento, auditorías | `security-doc` |
| Documento de Migración | Planificar la transición de AS-IS a TO-BE | `migration` |
| Plan de Pruebas | Planificar un ciclo de pruebas por funcionalidad/sprint | `test-plan` |
| Estrategia de Pruebas | Definir la estrategia global de QA del proyecto | `test-strategy` |
| Solicitud de Infraestructura | Solicitar un componente cloud (compute, storage, networking, etc.) | `infra-request` |
| Solicitud de Rol de Despliegue | Solicitar un rol IAM, rol RBAC o política para despliegue | `role-request` |

### Identifica la sección correcta

Todas las páginas se crean dentro del espacio de Confluence de tu proyecto (`{SPACE_KEY}`). Navega a la sección de tu dominio:

| Tu dominio | Sección en {SPACE_KEY} | Prefijo en el título |
|-------------|----------------------|-----------------|
| Frontend | Frontend | `[{PREFIX}-FRONT]` |
| Backend (servicios, APIs) | Backend & Services | `[{PREFIX}-BACK]` |
| Diseño (design system, prototipos) | UI/UX Design | `[{PREFIX}-DESIGN]` |
| Negocio (reglas, procesos, funcionalidades) | Business & Product | `[{PREFIX}-BIZ]` |
| Arquitectura (cloud, infra, despliegues) | Architecture & Cloud | `[{PREFIX}-ARCH]` |
| Seguridad (SDLC, cumplimiento) | Security & Compliance | `[{PREFIX}-SEC]` |
| QA & Testing (planes, estrategia, automatización) | QA & Testing | `[{PREFIX}-QA]` |
| Transversal (configuraciones globales, integraciones) | Governance Hub | `[{PREFIX}-HUB]` |

---

## 1.2 Crear una página paso a paso

### Paso 1: Crea la página desde una plantilla

1. Ve al espacio de Confluence de tu proyecto (`{SPACE_KEY}`) y navega a la sección de tu dominio
2. Haz clic en **"Create"** (el botón + en la parte superior derecha)
3. Selecciona la **plantilla del proyecto** que corresponda a tu tipo de documento
4. La plantilla viene con la estructura correcta — solo tienes que rellenarla

### Paso 2: Establece el título correcto

Sigue el patrón de nomenclatura:

```
[{PREFIX}-{SECTION}] {Type} — {Topic}
```

**Ejemplos**:
- `[PROJ-FRONT] Functional Specification — Contact Form`
- `[PROJ-BACK] API Specification — Notification Service`
- `ADR-0015 — Selection of Database Engine for Sessions`
- `ENV-PROD — Web Application`
- `RB — Backend — 502 Error in API Gateway`

### Paso 3: Rellena las Page Properties

Esta es la tabla de metadatos en la parte superior de la página. **Siempre** rellena:

| Field | Qué introducir |
|-------|--------------|
| Status | DRAFT (siempre empieza así) |
| Owner | Tu nombre (con @mención) |
| Approver | Tu tech lead o PO |
| Last Reviewed | La fecha de hoy |
| Next Review | +3 meses para documentos normales, +1 mes para configuraciones |
| Version | 1.0 |

### Paso 4: Escribe el contenido

- **Sigue las secciones de la plantilla** — no añadas ni elimines secciones
- **Usa tablas** para datos estructurados (requisitos, configuraciones, reglas)
- **Enlaza a tu issue tracker** usando el macro correspondiente cuando hagas referencia a epics/historias
- **Incrusta diseños** usando el macro de la herramienta de diseño cuando hagas referencia a artefactos visuales
- **Usa draw.io** para diagramas (no subas imágenes estáticas de diagramas)
- **No copies especificaciones de API** desde Swagger — enlaza a la Swagger UI y añade solo contexto adicional

### Paso 5: Añade etiquetas

Cada página necesita **al menos 3 etiquetas**:

1. **`team:{your-team}`** — Ejemplo: `team:frontend`
2. **`type:{doc-type}`** — Ejemplo: `type:func-spec`
3. **`status:draft`** — Siempre empieza como borrador

**Etiquetas adicionales según el caso**:
- Documentos funcionales: añade `phase:as-is` o `phase:to-be`
- Documentos de entorno: añade `env:dev`, `env:qa`, `env:stg` o `env:prod`
- Documentos de seguridad: añade `compliance:sdlc-security` o la normativa aplicable

### Paso 6: Cambia el Content State

En Confluence Cloud, usa el **Content State** nativo:
1. En la parte superior de la página, haz clic en la insignia de estado
2. Selecciona **"DRAFT"**
3. Cuando esté lista para revisión, cámbiala a **"IN REVIEW"**

### Paso 7: Publica y notifica

1. Haz clic en **"Publish"**
2. Menciona al revisor con **@nombre** en un comentario inline
3. Si aplica, añade un enlace a la página en el epic correspondiente del issue tracker

---

## 1.3 Proceso de revisión

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

> Para documentos de bajo riesgo (lecciones aprendidas, notas de implementación), la revisión por pares puede ser informal.

---

## 1.4 Mantén los documentos actualizados

### Cuándo actualizar

- Cuando completas una historia que afecta a un documento existente
- Cuando cambia la configuración de un entorno
- Cuando se toma una decisión que afecta a un ADR previo

### Cómo actualizar

1. Edita la página
2. Actualiza la tabla de Page Properties (nueva fecha de revisión, incrementa la versión)
3. Añade una entrada al Historial de Cambios al final de la página
4. Si el cambio es importante, pasa por el flujo de revisión

### Cuándo archivar

- Cuando un componente AS-IS se da de baja: cambia el estado a `status:obsolete` y el Content State a OBSOLETE
- Cuando se reemplaza por una nueva versión: cambia a `status:archived`

---

## 1.5 Migrar documentos existentes (Excel, PDF, Word)

Si tienes un documento en Excel, PDF o Word que necesita estar en Confluence:

1. **Crea una nueva página** usando la plantilla correspondiente
2. **Copia/adapta el contenido** al formato de Confluence (tablas, secciones, etc.)
3. **Adjunta el archivo original** a la página
4. **Añade una nota** al adjunto: *"Migrado el YYYY-MM-DD. Esta página de Confluence es la fuente de la verdad."*
5. **Etiqueta la página correctamente** con todas sus etiquetas
6. **Informa al equipo** de que el archivo original ya no debe editarse

> **No migres todo**. Prioriza los documentos TO-BE activos. Los documentos AS-IS que pronto quedarán obsoletos pueden permanecer como adjuntos sin migrar el contenido.

---

## 1.6 Errores comunes que evitar

| Error | Por qué es malo | Qué hacer en su lugar |
|---------|--------------|-------------------|
| Copiar toda la especificación de Swagger | Se desincroniza con el código | Enlaza a la Swagger UI, documenta solo el contexto adicional |
| Subir una captura de pantalla de un diseño | No puede actualizarse cuando cambia el diseño | Usa el macro de incrustación de la herramienta de diseño |
| Insertar un diagrama como imagen PNG | No puede editarse, queda obsoleto | Usa el macro de draw.io |
| Crear una página sin etiquetas | No aparece en búsquedas ni dashboards | Añade siempre al menos 3 etiquetas |
| Dejar las Page Properties en blanco | Los dashboards automatizados no funcionan | Rellena todos los campos requeridos |
| Escribir un secreto en Confluence | Riesgo de seguridad grave | Referencia la ruta en tu gestor de secretos |
| Duplicar contenido del issue tracker | Se desincroniza inmediatamente | Usa el macro del issue tracker con una consulta de filtro |
| No actualizar la versión en Page Properties | No se pueden rastrear los cambios | Incrementa siempre la versión al editar |

---

# PARTE 2: Documentación con Asistencia de IA

## 2.1 Visión general

La IA no reemplaza al autor — **acelera la creación y mejora el mantenimiento**. El equipo sigue siendo responsable de la exactitud y la aprobación de todo el contenido.

### Principio clave

> **La IA genera borradores. Los humanos validan y aprueban.** Ningún contenido generado por IA se publica como APPROVED sin revisión humana.

### Fases de adopción

| Fase | Qué hace la IA | Qué hace el equipo |
|-------|-------------|-------------------|
| **Fase 1** (actual) | Nada — el equipo establece la estructura | Crear páginas con plantillas, aplicar etiquetas, rellenar Page Properties |
| **Fase 2** | Buscar y responder preguntas sobre los docs existentes | Validar que las respuestas sean correctas |
| **Fase 3** | Generar borradores de documentos desde issue tracker, Git o solicitudes | Revisar borradores, corregir, aprobar |
| **Fase 4** | Detectar docs desactualizados, verificar cumplimiento de plantillas | Actuar sobre las alertas, resolver inconsistencias |

---

## 2.2 Usar el agente de documentación (Claude Code)

### Requisitos previos

Tener Claude Code instalado y estar en el directorio del proyecto:

```bash
cd /path/to/your/confluence-project
claude
```

### Generar un documento con el comando `/doc-confluence`

Dentro de una sesión de Claude Code:

```
/doc-confluence func-spec Contact Form
```

El agente:
1. Resuelve dónde están el framework, el repo de configuración y el repo de código destino
2. Carga la plantilla correspondiente (`templates/func-spec.md`)
3. Carga los estándares de documentación (`documentation-guide.md`)
4. Analiza el código del repo destino para extraer detalles técnicos
5. Te pide la información mínima necesaria (dominio, fase, epic del issue tracker)
6. Genera el documento completo con título, etiquetas, Page Properties y contenido
7. Guarda el archivo en `{Output path}/{origen}/` — una carpeta por repo documentado, `generic/` para enlaces — listo para copiar a Confluence

### Documentar un proyecto en otra ruta local

Por defecto el agente documenta el repo en el que estás trabajando. Para documentar
un proyecto que vive en otra ruta de tu máquina, registra su ruta en la tabla
`Code Repositories` de tu `project-config.md`, o pásala como tercer argumento:

```
/doc-confluence api-spec Payments Service /Users/tu-usuario/work/payments-api
```

El tercer argumento siempre gana sobre la tabla. Si Claude Code todavía no tiene
acceso a ese directorio, ejecuta antes `/add-dir /Users/tu-usuario/work/payments-api`.
Ver `customization-guide.md` Step 6 Mode B para la configuración completa.

También puedes pasar un **enlace** en vez de una ruta — una URL de OpenAPI, una página
de documentación pública:

```
/doc-confluence api-spec Stripe Payments https://docs.stripe.com/api
```

### Dónde se guardan tus documentos

Cada documento se archiva en una carpeta con el nombre del origen del que se sacó
la información:

```
output/
+-- mi-web-app/     <- documentos generados desde ese repo
+-- mi-api/         <- documentos generados desde ese repo
+-- generic/        <- el origen fue un enlace, o lo aportaste todo tú a mano
```

### Tipos de documentos que puede generar

| Comando | Qué genera |
|---------|------------------|
| `/doc-confluence func-spec {topic}` | Especificación Funcional |
| `/doc-confluence adr {decision title}` | Architecture Decision Record |
| `/doc-confluence api-spec {service name}` | Especificación de API |
| `/doc-confluence env-config {component}` | Configuración de Entorno |
| `/doc-confluence runbook {scenario}` | Runbook Operativo |
| `/doc-confluence security-doc {topic}` | Documento de Seguridad |
| `/doc-confluence migration {topic}` | Documento de Migración |
| `/doc-confluence test-plan {feature/sprint}` | Plan de Pruebas |
| `/doc-confluence test-strategy {project}` | Estrategia de Pruebas |
| `/doc-confluence infra-request {resource}` | Solicitud de Infraestructura |
| `/doc-confluence role-request {role name}` | Solicitud de Rol de Despliegue |

### Ejemplo completo

```
> /doc-confluence api-spec Notification Service

The agent asks:
- What is the base endpoint? -> /api/v1/notifications
- Authentication type? -> JWT via API Gateway
- Is there a Swagger link? -> https://swagger.example.com/notifications
- SLA target? -> 99.9% availability, p95 < 150ms

The agent generates:
-> output/proj-back-api-spec-notification-service.md

Title: [PROJ-BACK] API Specification — Notification Service
Labels: type:api-spec, status:draft, team:backend
Space: {PREFIX}-BACK
```

---

## 2.3 Documentos generados por IA: reglas del equipo

### Identificación

Todo documento generado por IA debe:
1. Llevar la etiqueta **`ai:auto-generated`**
2. Incluir una nota en la parte superior (usa el macro Info de Confluence):
   > "Este borrador fue generado por IA a partir de [fuente]. Requiere revisión humana antes de su aprobación."
3. Empezar en estado **DRAFT** — nunca puede ser APPROVED sin revisión humana

### Flujo de revisión para docs generados por IA

```
La IA genera el borrador
    |
    +-- Etiqueta: ai:auto-generated + status:draft
    |
    v
El autor revisa y corrige
    |
    +-- Verifica los datos técnicos
    +-- Valida las reglas de negocio
    +-- Completa las secciones con placeholders
    +-- Añade la etiqueta: ai:reviewed
    |
    v
Flujo de revisión normal
    |
    +-- Revisión por pares
    +-- Aprobación
    +-- Content State -> APPROVED
    |
    v
Documento listo
```

### Lo que la IA hace bien vs. lo que necesita supervisión humana

| La IA hace bien | Necesita supervisión humana |
|-------------|------------------------|
| Estructura y formato del documento | Exactitud de los datos técnicos |
| Aplicar convenciones de nomenclatura y etiquetas | Reglas de negocio específicas |
| Generar tablas con la estructura correcta | Valores de configuración reales |
| Rellenar secciones repetitivas | Decisiones de arquitectura |
| Detectar secciones faltantes | Contexto político/organizacional |
| Sugerir referencias cruzadas | Clasificación de seguridad |

---

## 2.4 Bot de búsqueda inteligente (Fase 2 — futuro)

Cuando se implemente, el equipo podrá preguntar en Slack/Teams:

```
@doc-bot What are the business rules for the contact form?
@doc-bot Which API does the frontend consume for notifications?
@doc-bot What is the production config for the CDN?
```

El bot busca en la documentación de Confluence y responde con la fuente.

**Requisitos para que funcione bien**:
- Las páginas deben estar etiquetadas correctamente (etiquetas obligatorias)
- Las páginas deben seguir las plantillas (secciones consistentes)
- Las páginas deben tener estado APPROVED (el bot prioriza los docs aprobados)

> Cuanto mejor sea la documentación manual, mejores serán las respuestas del bot.

---

## 2.5 Automatizaciones futuras (Fases 3-4)

Estas automatizaciones se implementarán progresivamente:

| Automatización | Qué hace | Cuándo estará disponible |
|-----------|-------------|--------------------------|
| **Borrador desde issue tracker** | Cuando un epic pasa a "Ready for Dev", se crea automáticamente un borrador de Especificación Funcional | Mes 5 |
| **Alerta de drift de API** | Cuando una spec OpenAPI cambia en Git, notifica que el doc podría estar desactualizado | Mes 6 |
| **Release notes automáticas** | Genera un borrador de release notes a partir de los commits y el issue tracker | Mes 7 |
| **Análisis de gaps AS-IS/TO-BE** | Compara los docs AS-IS y TO-BE y genera un borrador de plan de migración | Mes 8 |
| **Verificador de cumplimiento** | Verificación semanal de que las páginas cumplen con las plantillas | Mes 9 |
| **Detector de docs obsoletos** | Cruza Confluence con Git y el issue tracker para detectar docs potencialmente obsoletos | Mes 10 |

**El equipo no necesita hacer nada especial para prepararse**, solo seguir las buenas prácticas de la Parte 1. La estructura con plantillas y etiquetas es lo que habilita estas automatizaciones.

---

## 2.6 FAQ

**¿Puedo confiar ciegamente en un documento generado por IA?**
No. Revisa siempre los datos técnicos, las reglas de negocio y los valores de configuración. La IA es buena con la estructura y el formato, pero puede inventar detalles.

**¿Qué pasa si la IA genera algo incorrecto?**
Lo corriges como cualquier borrador. Por eso siempre empieza como DRAFT. La etiqueta `ai:auto-generated` permite rastrear que fue generado por IA.

**¿Necesito saber programar para usar el agente?**
Solo necesitas tener Claude Code instalado y saber ejecutar el comando `/doc-confluence`. El agente te guía con preguntas.

**¿Y si no tengo Claude Code?**
Documenta manualmente siguiendo la Parte 1. Las plantillas son idénticas — la IA solo agiliza el rellenado, no cambia la estructura.

**¿La IA tiene acceso a nuestros datos sensibles?**
El agente lee solo los archivos del proyecto de documentación (guías y plantillas). No tiene acceso a tu proveedor cloud, Confluence ni datos de producción. Los documentos generados se crean localmente.
