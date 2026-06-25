<!-- Versión fuente: 2026-06-25 -->
# Guía de Decisión: Qué va en Confluence

Esta guía establece los criterios para determinar dónde vive cada tipo de contenido en el proyecto. El objetivo es evitar la duplicación, mantener una única fuente de verdad y asegurar que cada herramienta se use para lo que mejor hace.

---

## Principio Rector

> **Confluence es para el conocimiento duradero. El trabajo transitorio vive en herramientas especializadas. Enlaza, no dupliques.**

### Qué es "Conocimiento Duradero"

Información que:
- Tiene valor más allá de un único sprint o iteración
- Necesita ser encontrada por personas que no participaron en su creación
- Requiere revisión, aprobación o auditoría
- Explica el **porqué** detrás de las decisiones técnicas o de negocio
- Necesita contexto narrativo que no encaja en un ticket o en un commit

### Qué es "Trabajo Transitorio"

Información que:
- Tiene un ciclo de vida corto (un sprint, una iteración)
- Se gestiona mejor con flujos de trabajo especializados (kanban, code review)
- Se genera o actualiza automáticamente a partir del código
- Es granular a nivel de tarea individual

---

## Matriz de Decisión

### Herramientas del Proyecto y Sus Dominios

| Herramienta | Es la fuente de verdad para | NO es el lugar para |
|------|---------------------------|----------------------|
| **Jira** | Historias de usuario, tareas, bugs, sprints, backlog | Documentación narrativa, especificaciones largas, guías |
| **Figma** | Diseños visuales, prototipos, sistema de diseño visual | Justificación de diseño, especificaciones de interacción escritas |
| **Git** | Código fuente, IaC, especificaciones OpenAPI autogeneradas | Contexto de negocio, decisiones arquitectónicas narrativas |
| **Swagger/OpenAPI** | Referencia técnica de la API (autogenerada desde el código) | Ejemplos de uso, reglas de negocio, SLAs |
| **Cloud Console/IaC** | Estado real de la infraestructura | Documentación del porqué se configuró de esa manera |
| **Secrets Manager** | Valores reales de secretos y credenciales | — |
| **Confluence** | Todo lo demás: conocimiento duradero, contexto, decisiones | Secretos, código, diseños visuales, tareas granulares |
| **Jira (testing)** | Bugs, casos de prueba individuales, ejecuciones de pruebas | Estrategia, planes, guías de testing (esos van en Confluence) |
| **Herramienta de Gestión de Pruebas (futuro)** | Gestión avanzada de casos de prueba y ejecuciones (evaluar cronograma de adopción) | Hasta su implementación, los planes viven en Confluence |

---

### Decisión por Tipo de Contenido

| Contenido | Dónde vive (fuente de verdad) | Qué hace Confluence | Cómo se conecta |
|---------|----------------------------------|----------------------|-----------------|
| **Historias de Usuario** | Jira | NO duplicar. La página de Feature en Confluence enlaza al epic/filtro de Jira | Macro Jira Issues con filtro JQL |
| **Tareas y bugs** | Jira | No documentar tareas individuales en Confluence | — |
| **Tableros de Sprint / Kanban** | Jira | No replicar | — |
| **Diseños UI/UX (visuales)** | Figma | Incrustar frames de Figma. Escribir la justificación, especificaciones de interacción y notas de revisión | Macro Figma Embed (nativa en Cloud) |
| **Código fuente** | Git | NO pegar grandes bloques de código. Documentar contexto, configuración, decisiones | Enlace al repo/archivo |
| **Referencia de API (autogenerada)** | Swagger/OpenAPI en Git | Enlazar a Swagger UI. Agregar contenido que NO está en la especificación: ejemplos de uso, reglas de negocio, SLAs, guía de errores | Enlace directo a la URL de Swagger |
| **Diagramas de arquitectura** | Confluence | **Fuente de verdad.** Crear con la macro draw.io (editable, no imágenes) | — |
| **Especificaciones funcionales** | Confluence | **Fuente de verdad.** Usar la plantilla Func Spec | Labels + Page Properties |
| **Reglas de negocio** | Confluence | **Fuente de verdad.** Secciones dedicadas en especificaciones funcionales o páginas independientes | — |
| **ADRs (decisiones técnicas)** | Confluence | **Fuente de verdad.** Usar la plantilla ADR | Labels `type:adr` |
| **Configuraciones de entorno** | Confluence (referencia) | Documentar **qué** existe y **dónde**, no los valores de los secretos. Los secretos referencian la ruta en tu secrets manager | Columna "¿Secreto? -> Ver Secrets Manager: /ruta" |
| **Secretos y credenciales** | Secrets Manager | **NUNCA en Confluence.** Solo referenciar la ruta | — |
| **Política de gestión de secretos** | Confluence | **Fuente de verdad.** Política y proceso, no valores | — |
| **SDLC de seguridad** | Confluence (sección Security) | **Fuente de verdad.** Checklists, políticas, reportes | Sección con Page Restrictions |
| **Documentación funcional (completa)** | Confluence | **Fuente de verdad.** Plantilla Func Spec con estado APPROVED | `status:approved` |
| **Documentación funcional (planificada)** | Confluence | Crear página con estado DRAFT y contenido mínimo (alcance, owner) | `status:draft` |
| **Solicitudes de despliegue** | Confluence (si no hay ServiceNow o similar) | **Fuente de verdad.** Registro con fecha, descripción, aprobador | Plantilla Deployment Request |
| **Creación de roles IAM** | Confluence (sección Architecture) | Documentar definición y justificación de cada rol | Subpágina bajo "Roles y Políticas IAM" |
| **Solicitud de componente de infraestructura** | Confluence (sección Architecture) | **Fuente de verdad.** Plantilla infra-request con trazabilidad. El email es solo el canal de solicitud; Confluence registra la solicitud y su estado | Labels `type:infra-request` |
| **Solicitud de rol de despliegue** | Confluence (sección Architecture) | **Fuente de verdad.** Plantilla role-request con trazabilidad y justificación de mínimo privilegio. El email es solo el canal de solicitud | Labels `type:role-request` |
| **Inventario de recursos provisionados** | Confluence (sección Architecture) | **Fuente de verdad.** Registro de todos los recursos cloud provisionados con identificadores, estado y página de referencia | Subpágina bajo "Infrastructure Requests" |
| **Flujos AS-IS** | Confluence | **Fuente de verdad.** Etiquetar con `phase:as-is`. Al ser decomisionado, cambiar a `status:obsolete` | Label `phase:as-is` |
| **Flujos TO-BE** | Confluence | **Fuente de verdad.** Etiquetar con `phase:to-be` | Label `phase:to-be` |
| **Documentos Excel existentes** | Migrar a Confluence | Migrar el contenido activo a páginas nativas. Adjuntar el original como respaldo | Ver sección de migración en la Guía de Documentación |
| **Documentos PDF/Word existentes** | Migrar a Confluence | Migrar el contenido activo a páginas nativas. Adjuntar el original como respaldo | Adjunto con nota de migración |
| **Imágenes de diagramas** | Migrar a draw.io en Confluence | Reemplazar con diagramas editables cuando sea factible | Macro draw.io |
| **Runbooks operativos** | Confluence | **Fuente de verdad.** Plantilla Runbook | Labels `type:runbook` |
| **Release notes** | Confluence | **Fuente de verdad.** Plantilla Release Notes | Labels `type:release-note` |
| **Onboarding** | Confluence | **Fuente de verdad.** Guía narrativa con enlaces a otras herramientas | Página en {PREFIX}-HUB |
| **Glosario de términos** | Confluence | **Fuente de verdad.** Página única en HUB | — |
| **Notas de reunión con decisiones** | Confluence | Solo si se toman decisiones que afectan al proyecto. No documentar reuniones rutinarias sin decisiones | Plantilla nativa Meeting Notes |
| **Estrategia de testing** | Confluence (sección QA) | **Fuente de verdad.** Plantilla Test Strategy | Labels `type:test-strategy` |
| **Planes de prueba** | Confluence (sección QA) | **Fuente de verdad.** Plantilla Test Plan | Labels `type:test-plan` |
| **Bugs individuales** | Jira | No duplicar en Confluence | — |
| **Casos de prueba detallados** | Jira (hoy) / Herramienta de gestión de pruebas (futuro) | No duplicar. Enlazar desde el plan de pruebas si se necesita contexto | Macro Jira Issues |
| **Ejecuciones de pruebas (runs)** | Jira (hoy) / Herramienta de gestión de pruebas (futuro) | No duplicar | — |
| **Excel de testing existente** | Migrar a Confluence (temporal) | Migrar contenido duradero (planes, estrategia) a {PREFIX}-QA. Cuando se adopte una herramienta de gestión de pruebas, los casos migran allí | Adjuntar original + migrar |
| **Datos de prueba (guía)** | Confluence (sección QA) | **Fuente de verdad.** Cómo generar y gestionar los datos de prueba | — |
| **Checklist pre-deploy** | Confluence (sección QA) | **Fuente de verdad.** Checklist reutilizable por ciclo | — |
| **Métricas de calidad** | Confluence (enlace al dashboard) | Enlazar al dashboard de Jira o Grafana. No duplicar los datos | Smart Links |
| **Framework de automatización (config)** | Git (código) + Confluence (contexto) | No pegar código. Documentar configuración, decisiones técnicas, herramientas | Enlace al repo |

---

## Árbol de Decisión Rápido

Usa este flujo cuando no estés seguro de dónde documentar algo:

```
¿Es una tarea, bug o historia de usuario?
  -> SÍ: Jira. No Confluence.

¿Es un diseño visual o prototipo?
  -> SÍ: Figma. Incrustar en Confluence si necesita contexto escrito.

¿Es código o una referencia de API autogenerada?
  -> SÍ: Git/Swagger. Enlazar desde Confluence.

¿Es un secreto, contraseña o credencial?
  -> SÍ: Secrets Manager. NUNCA en Confluence.

¿Es conocimiento que alguien necesitará en 3+ meses?
  -> SÍ: Confluence. Usa la plantilla apropiada.
  -> NO: ¿Es efímero? Evalúa si realmente necesita ser documentado.

¿Ya existe en otra herramienta como fuente de verdad?
  -> SÍ: No duplicar. Enlazar desde Confluence si se necesita contexto.
  -> NO: Confluence es el lugar.
```

---

## Regla de Conexión: "Enlaza, No Dupliques"

Cuando Confluence referencia contenido de otra herramienta:

1. **Incluye contexto breve** (1-2 frases) sobre qué existe y por qué importa
2. **Enlace directo** usando macros de Confluence Cloud:
   - Macro Jira Issues para historias/epics
   - Macro Figma Embed para diseños
   - Smart Links para URLs de Swagger, Git, dashboards
3. **Aporta valor único**: Escribe en Confluence solo lo que NO existe en la herramienta fuente — justificación, contexto de negocio, restricciones, decisiones

### Ejemplo Correcto

> **Form Service — Contact API**
>
> Este servicio procesa los formularios de contacto del sitio web institucional. Las reglas de validación se alinean con la regulación XYZ.
>
> **Referencia técnica**: [Enlace a Swagger UI]
>
> **Reglas de negocio no cubiertas por la especificación**:
> 1. El campo "tipo de consulta" controla los campos visibles según la tabla de reglas del área comercial
> 2. Los formularios enviados fuera del horario laboral disparan una respuesta automática diferida

### Ejemplo Incorrecto

> **Form Service — Contact API**
>
> POST /api/v1/contact
> Request body: { name: string, email: string, type: string, message: string }
> Response: { id: string, status: string }
> [... copia completa de la especificación de Swagger ...]

Esto se desincroniza del código en cuanto hay un cambio.
