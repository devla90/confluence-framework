# Changelog

All notable changes to this framework are documented here.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
Version numbers follow the policy in [README.md](README.md#versioning) — which is not
plain semver, because this project ships conventions rather than code.

## [Unreleased]

### Added

- `architecture` document type — an Architecture Overview covering a component's stack,
  top-level structure, entry points, key decisions, dependencies and constraints. The
  page tree already offered "Architecture and Stack" under several frentes with no
  template to fill it.
- `reference` document type — for pages that are consulted rather than read: glossaries,
  data dictionaries, service catalogs, inventories and matrices. Twenty-seven pages of the
  tree are that genre, more than any other gap found. The template forces the page to
  declare where the authoritative version lives and how it is refreshed, because a
  reference copied from elsewhere goes stale quietly and a reader trusts it anyway.
- `guide`, `release-note` and `deployment-request` document types. The label taxonomy
  declared `type:guide`, `type:release-note` and `type:deployment-request` but no template
  existed for any of them, and `guide` alone covers nineteen pages of the tree. Release
  notes and deployment requests already had a naming pattern in the standards — the
  framework said how to title them but not what to put in them.

- `scripts/install-adapter.sh` — one command installs the `/doc-confluence` adapter for
  any assistant (`claude-code`, `codex`, `devin`, `opencode`, `copilot`, `all`). The
  destinations were spread as copy-paste commands across three documents, each assuming
  the sibling layout; the script finds the framework from its own path instead. It
  refuses to overwrite an adapter that differs without `--force`, offers `--dry-run`,
  and `--link` for people working on the framework. POSIX `sh`, like Step 0, so it runs
  on Windows under Git Bash — where `--link` is refused, because Git Bash silently copies.
- Devin Local and Devin CLI adapter (`adapters/devin/skills/doc-confluence/SKILL.md`).
  Devin now runs on your machine (Devin Desktop, formerly Windsurf), reads `SKILL.md`
  skills and speaks MCP, so it gets the same `/doc-confluence` command as the others.

### Changed

- Devin is documented as two assistants. **Devin Local / CLI** supports Mode B and the
  Confluence lookups; **Devin cloud** keeps the old limits — no local disk, no MCP. The
  documents previously said Devin could not do Mode B at all, which is now only true of
  the cloud.
- Step 5 of the generation procedure now carries an exploration budget. Listing every
  file in a real repository can cost more than the rest of the procedure combined, and
  says less than the directory names do.
- MCP scope guidance now covers publishing. `confluence-mcp.md`, `compatibility.md` and
  every adapter said "read and search scopes only", which left no documented way to grant
  the write scope publishing needs. Read and search stay the default; write
  (`write:page:confluence` on a scoped token) is added only when the project publishes.

### Fixed

- `project-config-template.md` (and the config template): the "No credentials" note sat
  inside the Identity table, cutting `Confluence URL`, `Documentation language` and
  `Team size` out of it. The note now follows the table.
- Template counts said 11 where there are 16 types — `README.md`, `AGENTS.md`,
  `space-structure`, `page-structure`, and the Claude Code skill's description and its
  "Valid types" fallback.
- `generation-procedure.md`: "five things" for six capabilities, and Step 6 numbered 1, 2, 4.

Changes planned for the first public release (1.0.0).

### Added

- **Documentation standards** — naming convention `[{PREFIX}-{SUFFIX}] Type — Subject`,
  the `team:` / `type:` / `status:` / `phase:` / `env:` label taxonomy, and the
  DRAFT → IN-REVIEW → APPROVED → ARCHIVED lifecycle
- **11 page templates** — `func-spec`, `adr`, `api-spec`, `env-config`, `runbook`,
  `security-doc`, `migration`, `test-plan`, `test-strategy`, `infra-request`,
  `role-request`
- **Tool-neutral generation procedure** (`docs/generation-procedure.md`) — the single
  source of truth for how a document gets produced, naming no vendor's tool
- **Multi-assistant support** — `AGENTS.md` as the cross-tool entry point, plus thin
  adapters for Claude Code, OpenAI Codex, GitHub Copilot, opencode and Devin
- **Two working modes** — Mode A (run inside the code repo) and Mode B (run from the
  config repo, pointing at an external path or a URL)
- **Source-scoped output** — documents are filed under `{Output path}/{source}/`, one
  folder per repo documented and `generic/` for links
- **Project configuration** (`project-config-template.md`) — identity, paths, frentes,
  code repositories, technology labels, secrets platform and overrides
- **Governance and guides** — space structure, decision guide, team guide,
  customization guide, AI strategy and implementation roadmap, most with Spanish
  translations
- **Windows support** — the root-resolution block carries explicit guards for Git Bash
  path formats (`pwd -W`) and CRLF checkouts (`tr -d '\r'`)

[Unreleased]: https://github.com/devla90/confluence-framework/commits/develop
