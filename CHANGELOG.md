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

### Changed

- Step 5 of the generation procedure now carries an exploration budget. Listing every
  file in a real repository can cost more than the rest of the procedure combined, and
  says less than the directory names do.

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
