<!-- Versión fuente: 2026-06-25 -->
# Modelo de Gobernanza de la Documentación

Modelo ligero para un equipo de 5 a 15 personas. Sin burocracia excesiva — lo justo para mantener la calidad y la consistencia.

---

## 1. Roles

### Documentation Champion (1 persona, rota trimestralmente)

**No es un rol a tiempo completo.** Es una responsabilidad adicional que rota entre los tech leads o los miembros sénior del equipo.

**Responsabilidades:**
- Mantener la sección {PREFIX}-HUB (estándares, taxonomía, plantillas)
- Ejecutar el health check mensual (15 minutos)
- Coordinar la auditoría trimestral ligera
- Resolver conflictos de estructura o nomenclatura entre equipos
- Impulsar la iniciativa de integración con IA
- Incorporar a los nuevos miembros del equipo en los estándares de documentación

### Section Owner (1 por sección dentro del espacio {SPACE_KEY})

| Sección | Prefijo | Section Owner natural |
|---------|--------|-----------------------|
| Governance Hub | {PREFIX}-HUB | Documentation Champion |
| Frontend | {PREFIX}-FRONT | Frontend Tech Lead |
| Backend & Services | {PREFIX}-BACK | Backend Tech Lead |
| UI/UX Design | {PREFIX}-DESIGN | Design Lead |
| Business & Product | {PREFIX}-BIZ | Product Owner |
| Architecture & Cloud | {PREFIX}-ARCH | Solution Architect |
| Security & Compliance | {PREFIX}-SEC | Security Lead |
| QA & Testing | {PREFIX}-QA | QA Lead |

**Responsabilidades:**
- Mantener la estructura del árbol de páginas de su sección
- Asegurar que su equipo utiliza las plantillas y etiquetas correctas
- Revisar y aprobar documentos de su dominio
- Participar en la auditoría trimestral de su sección
- Gestionar las Page Restrictions cuando corresponda (p. ej., la sección de Security)

### Authors (todos los miembros del equipo)

**Responsabilidades:**
- Redactar y actualizar páginas usando las plantillas disponibles
- Aplicar las etiquetas correctas (mínimo: `team:`, `type:`, `status:`)
- Mantener actualizada la tabla de Page Properties
- Usar los Content States para indicar el estado del documento
- Atender los comentarios de revisión

---

## 2. Quién escribe, quién revisa, quién aprueba

| Tipo de documento | Autor típico | Revisor | Aprobador |
|---------------|---------------|----------|----------|
| Functional Specification | Desarrollador o Analista | Compañero del equipo | Tech Lead o PO de la sección |
| ADR | Arquitecto o Tech Lead | Equipo técnico (async) | Solution Architect |
| API Specification | Desarrollador Backend | Compañero de Backend | Backend Tech Lead |
| Environment Configuration | DevOps o Desarrollador | Tech Lead de la sección | Solution Architect |
| Runbook | Desarrollador o DevOps | Compañero del equipo | Tech Lead de la sección |
| Security Document | Security Lead | Arquitecto | Security Lead + Compliance |
| Migration Document | Analista o Desarrollador | Tech Lead de la sección | PO + Tech Lead |
| Test Plan | QA Lead o QA Analyst | Tech Lead de la sección bajo prueba | QA Lead |
| Testing Strategy | QA Lead | Arquitecto + Tech Leads | QA Lead |
| Infrastructure Request | Desarrollador o Tech Lead | Solution Architect | Solution Architect |
| Deployment Role Request | Desarrollador o DevOps | Security Lead + Arquitecto | Solution Architect |
| Business Rules | Product Owner o Analista | Stakeholder de negocio | Product Owner |
| Release Notes | Cualquier miembro del equipo | Tech Lead | Tech Lead |

### Proceso de revisión simplificado

1. El autor crea la página con estado **DRAFT** y Content State "DRAFT"
2. Cuando está lista, la cambia a **IN-REVIEW** y menciona (@) al revisor en un comentario inline
3. El revisor deja comentarios inline en la página (usando los comentarios de Confluence, sin editar directamente)
4. El autor resuelve los comentarios y notifica al aprobador
5. El aprobador cambia el estado a **APPROVED**

> Para documentos de bajo riesgo (notas de implementación, lecciones aprendidas), la revisión entre pares puede ser informal — basta con un "le eché un vistazo" del tech lead.

---

## 3. Cadencia de revisión

### Actividades recurrentes

| Frecuencia | Actividad | Responsable | Duración estimada |
|-----------|----------|-------------|-------------------|
| **Por sprint** | Revisar la documentación afectada por las historias completadas | Authors | Integrado en el trabajo del sprint |
| **Mensual** | Health check: revisar el dashboard de docs obsoletos, drafts estancados, etiquetas faltantes | Documentation Champion | 15 minutos |
| **Trimestral** | Auditoría ligera: cada Section Owner revisa su sección (completitud, exactitud, estructura) | Section Owners + Champion | 1 hora por Section Owner |
| **Trimestral** | Revisión de documentos de security/compliance | Security Lead | 2 horas |
| **Semestral** | Revisión de la taxonomía de etiquetas y plantillas (¿siguen funcionando?) | Documentation Champion + todos los Section Owners | 1 reunión de 30 min |

### Inclusión en la Definition of Done (Jira)

Añadir a la Definition of Done del equipo en Jira:

> **Documentación**: Si la historia afecta a la arquitectura, APIs, configuraciones o flujos de negocio, la documentación correspondiente en Confluence se crea o actualiza con el estado correcto.

Esto no significa documentarlo todo — solo lo que cae dentro de la guía de decisión.

---

## 4. Dashboard de salud de la documentación

Crear una página en **{PREFIX}-HUB / Governance and Reviews** con las siguientes consultas CQL usando la macro Content Report Table:

### Documentos potencialmente obsoletos

```sql
label = "status:approved" AND lastModified < now("-90d")
```

Muestra los documentos aprobados que no se han tocado en 90 días. No significa que estén mal — pero conviene verificarlos.

### Drafts estancados

```sql
label = "status:draft" AND created < now("-30d")
```

Drafts creados hace más de 30 días que siguen en estado borrador. Posiblemente abandonados.

### Páginas sin etiquetas obligatorias

Requiere revisión manual o un script. Busca páginas en cada sección que no tengan al menos `team:`, `type:` y `status:`.

### Documentos generados por IA pendientes de revisión

```sql
label = "ai:auto-generated" AND label NOT IN ("ai:reviewed")
```

### Documentos de compliance en riesgo

```sql
label = "compliance:audit-required" AND label = "status:draft"
```

---

## 5. Mecanismos de cumplimiento

### Lo que Confluence Cloud ofrece de forma nativa

| Mecanismo | Cómo usarlo |
|-----------|---------------|
| **Space Templates** | Configurar las plantillas como plantillas por defecto del espacio {SPACE_KEY}. Cuando alguien crea una página nueva, las plantillas del proyecto aparecen primero |
| **Content States** | Habilitarlos en el espacio. Los estados visuales (Draft, In Review, Approved) son visibles en el listado de páginas |
| **Page Restrictions** | Aplicar restricción de lectura sobre la página raíz "Security & Compliance" para que solo security, arquitectos y tech leads puedan acceder |
| **Page Restrictions** | Para páginas sensibles individuales, usar restricciones a nivel de página |
| **Watch Pages** | Los Section Owners deberían hacer "Watch" de toda su sección para recibir notificaciones de cambios |

### Lo que hacemos como equipo

| Práctica | Frecuencia |
|----------|-----------|
| Revisar el dashboard de salud en la reunión mensual del equipo (5 min) | Mensual |
| El Section Owner hace un spot-check de 3-5 páginas nuevas de su sección | Cada 2 semanas |
| El Documentation Champion envía un mini-informe por Slack/Teams tras la auditoría trimestral | Trimestral |

### Lo que NO hacemos

- No creamos procesos de aprobación que bloqueen el trabajo
- No exigimos documentación para tareas menores y bugs
- No obligamos a nadie a rellenar campos que no apliquen
- No penalizamos los errores — los corregimos y seguimos adelante

---

## 6. Gestión de documentos heredados (Excel, PDF, Word)

### Responsabilidad de la migración

| Tipo de documento | Responsable de la migración |
|---------------|--------------------------|
| Docs técnicos (configuraciones, APIs, arquitectura) | Tech Lead de la sección correspondiente (delega en el equipo) |
| Docs funcionales/de negocio | Product Owner o Business Analyst |
| Docs de security | Security Lead |
| Docs transversales | El Documentation Champion coordina, el equipo ejecuta |

### Criterios de priorización

Migrar activamente solo los documentos que:
1. Son TO-BE (el nuevo sistema que se está construyendo)
2. Son transversales y se consultan con frecuencia
3. Son requeridos para compliance/auditoría

Documentos AS-IS que quedarán obsoletos en menos de 3 meses: **adjuntar como archivo sin migrar el contenido.** Crear una página mínima con título, descripción de una línea y el archivo adjunto. Etiquetar con `phase:as-is` y `status:archived`.

---

## 7. Incorporación de nuevos miembros

Cuando un nuevo miembro se une al equipo:

1. Añadirlo a los espacios de Confluence correspondientes (permisos)
2. Compartir un enlace a la **Onboarding Guide** en {PREFIX}-HUB
3. El Section Owner de su dominio le muestra la estructura de la sección (5 min)
4. El nuevo miembro lee:
   - How to Write Documentation (Style Guide)
   - Template Catalog
   - Decision Guide — What Goes in Confluence
5. Su primer documento se crea usando una plantilla, y solicita feedback a un compañero
