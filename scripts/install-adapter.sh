#!/bin/sh
# Install the optional /doc-confluence adapter for one or more AI assistants.
#
# The adapters are a convenience: every assistant already follows the procedure from
# AGENTS.md. This script only puts each adapter where its assistant looks for it, so the
# destinations live in one place instead of being copy-pasted per document.
#
# POSIX sh, like Step 0 of the procedure: macOS, Linux, and Windows under Git Bash or WSL.
# See adapters/README.md for what each assistant gets and where.

set -eu

usage() {
  cat <<'EOF'
Usage: install-adapter.sh <assistant>... [options]

Assistants:
  claude-code   skill + agent      -> ~/.claude/skills, ~/.claude/agents      (all projects)
  codex         prompt             -> ~/.codex/prompts                        (all projects)
  devin         skill (Local/CLI)  -> ~/.config/devin/skills                  (all projects)
                                      %APPDATA%\devin\skills on Windows
  opencode      command            -> <target>/.opencode/commands             (one repo)
  copilot       prompt + instr.    -> <target>/.github                        (one repo)
  all           every one of the above

Options:
  --target DIR  Repo that receives the per-repo adapters (opencode, copilot).
                Default: the current directory — run it from your config repo.
  --link        Symlink instead of copying, so framework changes apply without
                reinstalling. For people working on the framework. Not on Windows.
  --force       Replace an existing adapter that differs from the framework's.
  --dry-run     Print what would happen and change nothing.
  -h, --help    Show this help.
EOF
}

# The framework is wherever this script lives, whatever the layout (sibling, submodule).
FRAMEWORK_ROOT=$(cd "$(dirname "$0")/.." && pwd)
ADAPTERS="$FRAMEWORK_ROOT/adapters"

TARGET=.
LINK=no
FORCE=no
DRY=no
ASSISTANTS=""

while [ $# -gt 0 ]; do
  case "$1" in
    --target) [ $# -ge 2 ] || { echo "--target needs a directory" >&2; exit 2; }; TARGET=$2; shift ;;
    --link) LINK=yes ;;
    --force) FORCE=yes ;;
    --dry-run) DRY=yes ;;
    -h|--help) usage; exit 0 ;;
    all) ASSISTANTS="claude-code codex devin opencode copilot" ;;
    claude-code|codex|devin|opencode|copilot) ASSISTANTS="$ASSISTANTS $1" ;;
    *) echo "Unknown argument: $1" >&2; usage >&2; exit 2 ;;
  esac
  shift
done

[ -n "$ASSISTANTS" ] || { usage >&2; exit 2; }

case "$(uname -s 2>/dev/null || echo unknown)" in
  MINGW*|MSYS*|CYGWIN*) WINDOWS=yes ;;
  *) WINDOWS=no ;;
esac

# Git Bash's ln -s silently copies unless Developer Mode and winsymlinks are set up, so a
# "link" would quietly go stale. Refuse rather than pretend.
if [ "$LINK" = yes ] && [ "$WINDOWS" = yes ]; then
  echo "--link is not supported on Windows: Git Bash copies instead of linking without" >&2
  echo "Developer Mode and MSYS=winsymlinks:nativestrict. Install without --link." >&2
  exit 2
fi

FAILED=0

# install <source> <destination>
install_one() {
  src=$1; dest=$2
  [ -e "$src" ] || { echo "  MISSING  $src — the framework checkout is incomplete" >&2; FAILED=1; return; }

  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    if [ "$LINK" = yes ]; then echo "  ok       $dest (already linked)"; return; fi
  elif [ -e "$dest" ] && [ "$LINK" = no ] && [ ! -L "$dest" ] && diff -rq "$src" "$dest" >/dev/null 2>&1; then
    echo "  ok       $dest (up to date)"; return
  fi

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    if [ "$FORCE" = no ]; then
      echo "  SKIPPED  $dest exists and differs — rerun with --force to replace it" >&2
      FAILED=1; return
    fi
    verb=replaced
  else
    verb=installed
  fi

  if [ "$DRY" = yes ]; then
    echo "  would be $verb: $dest"; return
  fi

  mkdir -p "$(dirname "$dest")"
  [ "$verb" = replaced ] && rm -rf "$dest"
  if [ "$LINK" = yes ]; then ln -s "$src" "$dest"; else cp -R "$src" "$dest"; fi
  echo "  $verb $dest"
}

if [ "$WINDOWS" = yes ] && [ -n "${APPDATA:-}" ]; then
  DEVIN_SKILLS=$(cd "$APPDATA" && pwd)/devin/skills
else
  DEVIN_SKILLS=${XDG_CONFIG_HOME:-$HOME/.config}/devin/skills
fi

for a in $ASSISTANTS; do
  case "$a" in
    opencode|copilot)
      [ -d "$TARGET" ] || { echo "--target $TARGET is not a directory" >&2; exit 2; }
      T=$(cd "$TARGET" && pwd)
      if [ "$T" = "$FRAMEWORK_ROOT" ]; then
        echo "$a: refusing to install into the framework repo itself — run from your config repo or pass --target" >&2
        FAILED=1; continue
      fi ;;
  esac

  echo "$a:"
  case "$a" in
    claude-code)
      install_one "$ADAPTERS/claude-code/skills/doc-confluence" "$HOME/.claude/skills/doc-confluence"
      install_one "$ADAPTERS/claude-code/agents/confluence-doc" "$HOME/.claude/agents/confluence-doc" ;;
    codex)
      install_one "$ADAPTERS/codex/doc-confluence.md" "$HOME/.codex/prompts/doc-confluence.md" ;;
    devin)
      install_one "$ADAPTERS/devin/skills/doc-confluence" "$DEVIN_SKILLS/doc-confluence" ;;
    opencode)
      install_one "$ADAPTERS/opencode/doc-confluence.md" "$T/.opencode/commands/doc-confluence.md" ;;
    copilot)
      install_one "$ADAPTERS/copilot/doc-confluence.prompt.md" "$T/.github/prompts/doc-confluence.prompt.md"
      install_one "$ADAPTERS/copilot/copilot-instructions.md" "$T/.github/copilot-instructions.md" ;;
  esac
done

if [ "$FAILED" -ne 0 ]; then exit 1; fi
[ "$DRY" = yes ] && echo "Dry run — nothing was changed."
exit 0
