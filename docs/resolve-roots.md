> Part of [`generation-procedure.md`](generation-procedure.md). It lives in its own file
> so that assistants which preload the roots — by running this block before reading the
> procedure — do not pay for it twice. If you are such an assistant, you already have the
> output and can go straight to Step 1.

# Step 0: Resolve the roots

Two locations must be known before anything else, and neither can be assumed from
the current directory:

- **`CONFIG_ROOT`** — the directory holding `project-config.md`
- **`FRAMEWORK_ROOT`** — the framework directory holding `templates/` and `docs/`

Run this. It is POSIX `sh` and works unchanged on macOS, Linux, WSL and Git Bash on
Windows. Replace `func-spec` with the document type being generated.

```sh
T=func-spec

unset CDPATH
A() { (cd "$1" 2>/dev/null && { pwd -W 2>/dev/null || pwd; }); }

CFG=""; SKIPPED=""
for d in . .. ./confluence-config-* ../confluence-config-*; do
  [ -f "$d/project-config.md" ] || continue
  N=$(grep -m1 '^| *Project name *|' "$d/project-config.md" | tr -d '\r' \
      | awk -F'|' '{gsub(/^ +| +$/,"",$3); print $3}')
  case "$N" in \{*) SKIPPED="$SKIPPED $d"; continue ;; esac
  CFG=$(A "$d"); break
done

FW=""
if [ -n "$CFG" ]; then
  P=$(grep -m1 '^| *Framework path *|' "$CFG/project-config.md" | tr -d '\r' \
      | awk -F'|' '{gsub(/^ +| +$/,"",$3); print $3}')
  case "$P" in ""|\{*) P="" ;; esac
  [ -n "$P" ] && [ -f "$CFG/$P/templates/func-spec.md" ] && FW=$(A "$CFG/$P")
fi
if [ -z "$FW" ]; then
  for d in . .. ./confluence-framework ../confluence-framework "$CFG/../confluence-framework"; do
    [ -f "$d/templates/func-spec.md" ] && FW=$(A "$d") && break
  done
fi

echo "CONFIG_ROOT=${CFG:-NOT_FOUND}"
echo "FRAMEWORK_ROOT=${FW:-NOT_FOUND}"
[ -n "$SKIPPED" ] && echo "SKIPPED_UNFILLED:$SKIPPED"
echo "--- project-config.md ---"
if [ -n "$CFG" ]; then
  cat "$CFG/project-config.md"
elif [ -n "$SKIPPED" ]; then
  echo "NOT_FOUND: the only candidate(s) --$SKIPPED-- still hold {placeholder} values,"
  echo "so they are unfilled templates, not a project. Fill in project-config.md there,"
  echo "or start the session from the real config repo."
else
  echo "NOT_FOUND: no project-config.md in . .. or a sibling confluence-config-*."
fi
echo "--- documentation-guide.md (sections 1, 8, 9) ---"
{ [ -n "$FW" ] && awk '/^## (1|8|9)\./{p=1;print;next} /^## [0-9]+\./{p=0} p' \
    "$FW/docs/documentation-guide.md"; } \
  || echo "NOT_FOUND: framework root not resolved."
echo "--- template: $T ---"
{ [ -n "$FW" ] && cat "$FW/templates/$T.md" 2>/dev/null; } \
  || echo "TEMPLATE NOT FOUND. Valid types: func-spec architecture adr api-spec env-config runbook security-doc migration test-plan test-strategy infra-request role-request"
```

**Why each guard is there** — do not simplify them away:

- `pwd -W` yields a native `C:/Users/...` root on Git Bash instead of the MSYS
  `/c/Users/...` form, which file-reading tools cannot open. It fails harmlessly on
  POSIX and falls back to `pwd`.
- `tr -d '\r'` stops a CRLF checkout from gluing a carriage return onto the parsed
  path, producing a directory that does not exist.
- The `case "$P" in \{*)` guard rejects an unfilled `{placeholder}` in the config.
- The same guard on `Project name` skips a config repo that is still an **unfilled
  template**. Without it, an untouched `confluence-config-template/` sitting beside your
  real project can win the `confluence-config-*` glob — it expands alphabetically, first
  match wins — and the assistant would silently load `{placeholder}` values instead of
  your project's. Anything whose `Project name` does not start with `{` is treated as a
  real config, so a config missing that row entirely still resolves as before.

Use the two absolute roots it prints for **every** path from here on. Never use bare
relative paths like `templates/x.md` or `docs/x.md` — they only resolve from one
specific directory.

If either root printed `NOT_FOUND`, stop and ask the user for the missing path
instead of guessing. Before asking, check one common cause:

**`CONFIG_ROOT=NOT_FOUND` with a `SKIPPED_UNFILLED:` line.** Every candidate found was
an unfilled template. Either the user has not filled in `project-config.md` yet, or the
session was started somewhere that only sees the template. Say which directories were
skipped — do not fall back to reading them.

**`FRAMEWORK_ROOT=NOT_FOUND` with a `.gitmodules` present.** If the config repo has a
`.gitmodules` declaring `confluence-framework`, and that directory exists but is empty,
the submodule was never initialized — someone cloned without `--recurse-submodules`.
Tell the user to run:

```sh
git submodule update --init --recursive
```

That fixes it without re-cloning. Do not hunt for a wrong `Framework path` row in this
case; the row is fine, the files are simply not there yet.

If more than one `confluence-config-*` sibling exists the first
match wins — confirm with the user that it is the right project.

