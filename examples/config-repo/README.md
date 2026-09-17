# Example Config Repo — Acme Corp Web Portal

A **filled-in** config repo, shown so you can see what real values look like next to the
placeholders in the template. Everything here is fictional.

## This is for reading, not cloning

Do not copy this directory to start a project. Use the template repository instead —
press **Use this template** on
[confluence-config-template](https://github.com/devla90/confluence-config-template), which
gives you your own repo with its own history. See
[`../../docs/customization-guide.md`](../../docs/customization-guide.md).

## What a config repo contains

| File | What it holds | Here |
|------|---------------|------|
| `project-config.md` | Identity, paths, frentes, code repositories, tech labels, secrets platform | Prefix `ACME`, space `ACMEWEB`, 5 frentes |
| `AGENTS.md` | Entry point every AI assistant reads. Points at the framework's generation procedure | Filled for Acme |
| `page-structure.md` | The actual Confluence page tree for the project | Full tree across all frentes |
| `output/` | Where generated documents land, one subfolder per source | Empty until you generate something |

A `CLAUDE.md` whose first line is `@AGENTS.md` is optional — it lets Claude Code reuse the
same instructions without a second copy.

## Things worth noticing

**Relative repo paths.** The `Code Repositories` table uses `../acme-web-portal` rather
than `/Users/someone/work/acme-web-portal`. This file is committed and shared, so absolute
paths would break for every teammate and on every new machine.

**Frentes without code.** The Design row has an empty path — it is Figma only. An empty
path is valid and means "generate from placeholders, there is nothing to read".

**No secrets.** The Secrets Platform section names *where* credentials live (AWS Secrets
Manager) and never a value. Generated documents follow the same rule: variable names only.
