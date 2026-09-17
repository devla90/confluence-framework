---
name: doc-confluence
description: Generates professional Confluence documentation following the framework standards. Reads project-config.md for project-specific values and can analyze an external local code repository, or a URL, to extract technical information. Supports all document types (func-spec, adr, api-spec, env-config, runbook, security-doc, migration, test-plan, test-strategy, infra-request, role-request).
when_to_use: When the user needs to create Confluence documentation, generate a new page from a template, or document a feature, API, environment, decision, runbook, security policy, or migration plan -- either for the current repo or for a project at another local path.
argument-hint: <type> <subject> [target-path] -- types: func-spec | architecture | adr | api-spec | env-config | runbook | guide | security-doc | migration | release-note | deployment-request | test-plan | test-strategy | infra-request | role-request
arguments: [tipo, tema, target]
allowed-tools: Read, Bash, Write, Edit, Glob, Grep, WebFetch
model: sonnet
effort: high
user-invocable: true
---

## Objective

Generate a professional document for Confluence Cloud following the framework standards, adapted to the current project's configuration.

**Document type**: `$tipo`
**Subject**: `$tema`
**Source, path or URL (optional)**: `$target`

## Bootstrap: resolve roots and preload context

This runs Step 0 of the procedure eagerly, so the roots and the three files it needs are already in context by the time you start. It preloads sections 1, 8 and 9 of the standards -- naming, document types and quality -- which is everything the procedure asks for, so it never has to open that file again. Use the absolute `CONFIG_ROOT` and `FRAMEWORK_ROOT` it prints for every subsequent path -- never bare relative paths like `templates/x.md`.

!`unset CDPATH; A(){ (cd "$1" 2>/dev/null && { pwd -W 2>/dev/null || pwd; }); }; T="$tipo"; CFG=""; SKIPPED=""; for d in . .. ./confluence-config-* ../confluence-config-*; do [ -f "$d/project-config.md" ] || continue; N=$(grep -m1 '^| *Project name *|' "$d/project-config.md" | tr -d '\r' | awk -F'|' '{gsub(/^ +| +$/,"",$3); print $3}'); case "$N" in \{*) SKIPPED="$SKIPPED $d"; continue ;; esac; CFG=$(A "$d"); break; done; FW=""; if [ -n "$CFG" ]; then P=$(grep -m1 '^| *Framework path *|' "$CFG/project-config.md" | tr -d '\r' | awk -F'|' '{gsub(/^ +| +$/,"",$3); print $3}'); case "$P" in ""|\{*) P="" ;; esac; [ -n "$P" ] && [ -f "$CFG/$P/templates/func-spec.md" ] && FW=$(A "$CFG/$P"); fi; if [ -z "$FW" ]; then for d in . .. ./confluence-framework ../confluence-framework "$CFG/../confluence-framework"; do [ -f "$d/templates/func-spec.md" ] && FW=$(A "$d") && break; done; fi; echo "CONFIG_ROOT=${CFG:-NOT_FOUND}"; echo "FRAMEWORK_ROOT=${FW:-NOT_FOUND}"; [ -n "$SKIPPED" ] && echo "SKIPPED_UNFILLED:$SKIPPED"; echo "SHELL_UNAME=$(uname -s 2>/dev/null || echo unknown)"; echo "--- project-config.md ---"; if [ -n "$CFG" ]; then cat "$CFG/project-config.md"; elif [ -n "$SKIPPED" ]; then echo "NOT_FOUND: the only candidate(s) --$SKIPPED-- still hold {placeholder} values, so they are unfilled templates, not a project. Ask the user to fill project-config.md there, or to start from the real config repo."; else echo "NOT_FOUND: no project-config.md in . .. or a sibling confluence-config-*. Ask the user for the config repo path."; fi; echo "--- documentation-guide.md (sections 1, 8, 9) ---"; { [ -n "$FW" ] && awk '/^## (1|8|9)\./{p=1;print;next} /^## [0-9]+\./{p=0} p' "$FW/docs/documentation-guide.md"; } || echo "NOT_FOUND: framework root not resolved. Ask the user for the confluence-framework path."; echo "--- template: $T ---"; { [ -n "$FW" ] && cat "$FW/templates/$T.md" 2>/dev/null; } || echo "TEMPLATE NOT FOUND. Valid types: func-spec adr api-spec env-config runbook security-doc migration test-plan test-strategy infra-request role-request"`

If either root printed `NOT_FOUND`, stop and ask the user for the missing path instead of guessing. If more than one `confluence-config-*` sibling exists the first match wins -- confirm with the user that it is the right project.

## Follow the procedure

**Read `$FRAMEWORK_ROOT/docs/generation-procedure.md` and follow it from Step 1 onward.** Step 0 is already done by the bootstrap above.

That file is the single source of truth for this flow -- source resolution, per-type source analysis, template filling, the `{Output path}/{source}/` layout, the secrets rule and the invention rule. It is deliberately tool-neutral so every assistant runs the same logic. Do not restate or improvise around it.

## Claude Code specifics

These are the only things the neutral procedure cannot name:

| Procedure says | Use |
|----------------|-----|
| "list files matching a pattern" | `Glob` |
| "search file contents" | `Grep` |
| "read a file" | `Read` |
| "fetch a URL" | `WebFetch` |
| "write a file" | `Write` |
| "run a shell command" | `Bash` |
| "grant the assistant access to that folder" | Tell the user to run `/add-dir <path>`, or add it to `permissions.additionalDirectories` in `settings.json` |

Scope `Glob` and `Grep` to the resolved source path -- do not sweep the whole filesystem.

Both working modes are supported here: Mode A (running inside the code repo) and Mode B (running from the config repo, pointing at an external path or URL). See `$FRAMEWORK_ROOT/docs/compatibility.md`.
