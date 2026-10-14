#!/bin/sh
#
# check-kit.sh: the starter kit's release checks.
#
# Run it from anywhere inside the kit's repository:
#
#     sh scripts/check-kit.sh
#
# Exit status 0 means every check passed; 1 means at least one failed.
# Each check prints how much it scanned, and a check that finds nothing to
# scan fails, so a check that silently did nothing can't pass.
#
# Needs only git and standard Unix tools (sha256sum, or shasum on older
# macOS). The private denylist lives outside the repository, so its terms
# are never published: set KIT_DENYLIST, or use the default path below.
# See MAINTAINERS.md.
#
set -u
LC_ALL=C
export LC_ALL

DENYLIST=${KIT_DENYLIST:-$HOME/.config/wiki-kit/denylist.txt}
SIZE_LIMIT=24000           # top AGENTS.md plus the largest wiki rules file, in bytes
SOFT_LIMIT=12000           # soft target for the top AGENTS.md alone
PENDING_FILES="Arcqus-AI-LLM-Wiki-Primer.pdf"   # linked files a maintainer adds later
SENTENCE="Read START-HERE.md and build my first wiki."

if ! root=$(git rev-parse --show-toplevel 2>/dev/null); then
  echo "check-kit: run this inside the kit's git repository" >&2
  exit 2
fi
cd "$root" || exit 2

tmp=$(mktemp -d "${TMPDIR:-/tmp}/check-kit.XXXXXX") || exit 2
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

failed=0
warned=0
pass() { printf 'PASS  %s\n' "$1"; }
fail() { printf 'FAIL  %s\n' "$1"; failed=$((failed + 1)); }
warn() { printf 'WARN  %s\n' "$1"; warned=$((warned + 1)); }
detail() { head -n 40 "$1" | sed 's/^/        /'; }
count() { wc -l < "$1" | tr -d ' '; }
sha256_of() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | cut -d' ' -f1
  else
    shasum -a 256 "$1" | cut -d' ' -f1
  fi
}

# Every file git would publish: tracked files plus new files that aren't ignored.
git ls-files --cached --others --exclude-standard | sort -u > "$tmp/listed"
: > "$tmp/files"
while IFS= read -r f; do
  [ -f "$f" ] && printf '%s\n' "$f" >> "$tmp/files"
done < "$tmp/listed"
grep '\.md$' "$tmp/files" > "$tmp/md" || :
nfiles=$(count "$tmp/files")
nmd=$(count "$tmp/md")

# 1. Dashes: no em dash, en dash, or spaced hyphen in any Markdown file.
em=$(printf '\342\200\224')
en=$(printf '\342\200\223')
: > "$tmp/dash"
while IFS= read -r f; do
  grep -H -n -e "$em" -e "$en" -e '[^[:space:]] - ' "$f" >> "$tmp/dash" 2>/dev/null
done < "$tmp/md"
if [ "$nmd" -eq 0 ]; then
  fail "dashes: found no Markdown files to scan"
elif [ -s "$tmp/dash" ]; then
  fail "dashes: $(count "$tmp/dash") lines with an em dash, en dash, or spaced hyphen, in $nmd Markdown files"
  detail "$tmp/dash"
else
  pass "dashes: $nmd Markdown files, no em dash, en dash, or spaced hyphen"
fi

# 2. Denylist: no private term in any file, any path, or this branch's commit
#    messages; no phone numbers or street addresses. Hits print as file:line
#    only, so the private terms themselves aren't echoed.
if [ ! -f "$DENYLIST" ]; then
  fail "denylist: no denylist at $DENYLIST, so this check didn't run (see MAINTAINERS.md)"
else
  # Drop comments and blank lines: an empty pattern would match everything.
  grep -v '^[[:space:]]*#' "$DENYLIST" | grep -v '^[[:space:]]*$' > "$tmp/terms" || :
  nterms=$(count "$tmp/terms")
  if [ "$nterms" -eq 0 ]; then
    fail "denylist: $DENYLIST has no terms, so this check didn't run"
  else
    : > "$tmp/deny"
    while IFS= read -r f; do
      grep -H -n -I -i -w -F -f "$tmp/terms" "$f" 2>/dev/null | cut -d: -f1,2 >> "$tmp/deny"
      grep -H -n -I -E \
        -e '(^|[^0-9])[(]?[0-9][0-9][0-9][)]?[-. ][0-9][0-9][0-9][-. ][0-9][0-9][0-9][0-9]([^0-9]|$)' \
        -e '[0-9] [A-Z][a-z]+ (Street|St|Avenue|Ave|Road|Rd|Boulevard|Blvd|Lane|Ln|Drive|Dr|Court|Ct|Way|Place|Pl)([^a-z]|$)' \
        "$f" 2>/dev/null | cut -d: -f1,2 | sed 's/$/ (looks like a phone number or street address)/' >> "$tmp/deny"
    done < "$tmp/files"
    grep -i -w -F -f "$tmp/terms" "$tmp/files" | sed 's/^/path: /' >> "$tmp/deny"
    ncommits=0
    base=$(git merge-base HEAD origin/main 2>/dev/null || git merge-base HEAD main 2>/dev/null || :)
    if [ -n "$base" ]; then
      git rev-list "$base..HEAD" > "$tmp/commits"
      while IFS= read -r c; do
        ncommits=$((ncommits + 1))
        if git log -1 --format=%B "$c" | grep -q -i -w -F -f "$tmp/terms"; then
          printf 'commit message of %s\n' "$(git log -1 --format=%h "$c")" >> "$tmp/deny"
        fi
      done < "$tmp/commits"
    fi
    if [ -s "$tmp/deny" ]; then
      fail "denylist: $(count "$tmp/deny") hits ($nterms terms; $nfiles files and their paths; $ncommits commit messages)"
      detail "$tmp/deny"
    else
      pass "denylist: $nterms terms; $nfiles files and their paths; $ncommits commit messages on this branch; no hits, no phone numbers or street addresses"
    fi
  fi
fi

# 3. No Claude-only tokens anywhere, and every CLAUDE.md is the one line @AGENTS.md.
: > "$tmp/tokens"
while IFS= read -r f; do
  [ "$f" = scripts/check-kit.sh ] && continue
  grep -H -n -I -F -e '$ARGUMENTS' -e '@../' -e '.claude/commands' "$f" >> "$tmp/tokens" 2>/dev/null
done < "$tmp/files"
nclaude=0
while IFS= read -r f; do
  case "$f" in
    CLAUDE.md|*/CLAUDE.md) ;;
    *) continue ;;
  esac
  nclaude=$((nclaude + 1))
  if [ "$(cat "$f")" != "@AGENTS.md" ] || [ "$(count "$f")" != 1 ]; then
    echo "$f: isn't exactly the single line @AGENTS.md" >> "$tmp/tokens"
  fi
  [ -f "$(dirname "$f")/AGENTS.md" ] || echo "$f: has no AGENTS.md beside it" >> "$tmp/tokens"
done < "$tmp/files"
if [ "$nclaude" -eq 0 ]; then
  fail "tokens: found no CLAUDE.md files"
elif [ -s "$tmp/tokens" ]; then
  fail "tokens: $(count "$tmp/tokens") problems in $nfiles files"
  detail "$tmp/tokens"
else
  pass "tokens: $nfiles files have no \$ARGUMENTS, @../, or .claude/commands; all $nclaude CLAUDE.md files are the one line @AGENTS.md"
fi

# 4. Size budget: the top AGENTS.md plus the largest wiki rules file.
if [ ! -f AGENTS.md ]; then
  fail "size: there's no top-level AGENTS.md"
else
  rootb=$(wc -c < AGENTS.md | tr -d ' ')
  maxb=0
  maxf=""
  for f in archetypes/*-overlay.md examples/*/AGENTS.md; do
    [ -f "$f" ] || continue
    b=$(wc -c < "$f" | tr -d ' ')
    if [ "$b" -gt "$maxb" ]; then maxb=$b; maxf=$f; fi
  done
  total=$((rootb + maxb))
  if [ -z "$maxf" ]; then
    fail "size: found no wiki rules files to measure"
  elif [ "$total" -le "$SIZE_LIMIT" ]; then
    pass "size: AGENTS.md ($rootb bytes) + $maxf ($maxb) = $total bytes, within $SIZE_LIMIT"
  else
    fail "size: AGENTS.md ($rootb bytes) + $maxf ($maxb) = $total bytes, over $SIZE_LIMIT"
  fi
  if [ "$rootb" -gt "$SOFT_LIMIT" ]; then
    warn "size: AGENTS.md alone is $rootb bytes, over the $SOFT_LIMIT soft target"
  fi
fi

# 5. Adapters: every operation has a wrapper in each adapter folder, and every
#    wrapper points at an operation that exists.
: > "$tmp/adapters"
nops=0
for op in _shared/operations/*.md; do
  [ -f "$op" ] || continue
  nops=$((nops + 1))
  name=$(basename "$op" .md)
  for dir in .agents/skills .claude/skills; do
    w="$dir/wiki-$name/SKILL.md"
    if [ ! -f "$w" ]; then
      echo "missing: $w" >> "$tmp/adapters"
      continue
    fi
    grep -q "^name: wiki-$name\$" "$w" || echo "$w: name isn't wiki-$name" >> "$tmp/adapters"
    grep -q '^description: ..*' "$w" || echo "$w: has no description" >> "$tmp/adapters"
    grep -q -F "_shared/operations/$name.md" "$w" || echo "$w: doesn't point at _shared/operations/$name.md" >> "$tmp/adapters"
  done
done
nwrap=0
for w in .agents/skills/wiki-*/SKILL.md .claude/skills/wiki-*/SKILL.md; do
  [ -f "$w" ] || continue
  nwrap=$((nwrap + 1))
  ref=$(grep -o '_shared/operations/[a-z0-9-]*\.md' "$w" | head -n 1)
  if [ -z "$ref" ] || [ ! -f "$ref" ]; then
    echo "$w: points at an operation that doesn't exist (${ref:-none named})" >> "$tmp/adapters"
  fi
done
if [ "$nops" -eq 0 ]; then
  fail "adapters: found no operations in _shared/operations/"
elif [ -s "$tmp/adapters" ]; then
  fail "adapters: $(count "$tmp/adapters") problems ($nops operations, $nwrap wrappers)"
  detail "$tmp/adapters"
else
  pass "adapters: $nops operations, $nwrap wrappers, each complete and pointing at a file that exists"
fi

# 6. Links: every relative markdown link resolves. Links inside code are
#    skipped, as are template placeholders. A declared pending file warns.
: > "$tmp/broken"
: > "$tmp/pending"
nlinks=0
while IFS= read -r f; do
  dir=$(dirname "$f")
  awk '
    /^[ \t]*```/ { code = !code; next }
    code { next }
    {
      line = $0
      gsub(/`[^`]*`/, "", line)
      while (match(line, /[]][(][^)]*[)]/)) {
        print substr(line, RSTART + 2, RLENGTH - 3)
        line = substr(line, RSTART + RLENGTH)
      }
    }' "$f" > "$tmp/targets"
  while IFS= read -r t; do
    case "$t" in
      ""|http://*|https://*|mailto:*|"#"*) continue ;;
      *"<"*|*"{"*) continue ;;
    esac
    t=${t%%#*}
    t=${t%% *}
    nlinks=$((nlinks + 1))
    [ -e "$dir/$t" ] && continue
    pending=no
    for p in $PENDING_FILES; do
      [ "$(basename "$t")" = "$p" ] && pending=yes
    done
    if [ "$pending" = yes ]; then
      echo "$f -> $t" >> "$tmp/pending"
    else
      echo "$f -> $t" >> "$tmp/broken"
    fi
  done < "$tmp/targets"
done < "$tmp/md"
if [ "$nlinks" -eq 0 ]; then
  fail "links: found no relative links to check in $nmd Markdown files"
elif [ -s "$tmp/broken" ]; then
  fail "links: $(count "$tmp/broken") of $nlinks relative links don't resolve"
  detail "$tmp/broken"
else
  pass "links: all $nlinks relative links in $nmd Markdown files resolve"
fi
if [ -s "$tmp/pending" ]; then
  warn "links: a declared pending file isn't there yet (add it before release):"
  detail "$tmp/pending"
fi

# 7. Sample ledger: each row's sha256 matches its raw file, and every raw
#    file has a row.
: > "$tmp/ledger"
nrows=0
nraw=0
for ledger in examples/*/_state/sources.md; do
  [ -f "$ledger" ] || continue
  wiki=${ledger%/_state/sources.md}
  awk -F'|' 'NF > 5 { f = $2; h = $3; gsub(/[ `]/, "", f); gsub(/[ `]/, "", h);
             if (length(h) == 64 && h ~ /^[0-9a-f]+$/) print f, h }' "$ledger" > "$tmp/rows"
  while read -r file hash; do
    nrows=$((nrows + 1))
    if [ ! -f "$wiki/raw/$file" ]; then
      echo "$ledger: $file isn't in $wiki/raw/" >> "$tmp/ledger"
      continue
    fi
    actual=$(sha256_of "$wiki/raw/$file")
    if [ "$actual" != "$hash" ]; then
      echo "$ledger: $file has sha256 $(printf '%s' "$actual" | cut -c1-12)..., but the ledger says $(printf '%s' "$hash" | cut -c1-12)..." >> "$tmp/ledger"
    fi
  done < "$tmp/rows"
  for r in "$wiki"/raw/*; do
    [ -f "$r" ] || continue
    nraw=$((nraw + 1))
    b=$(basename "$r")
    awk -v b="$b" '$1 == b { found = 1 } END { exit !found }' "$tmp/rows" || echo "$ledger: no row for raw/$b" >> "$tmp/ledger"
  done
done
if [ "$nrows" -eq 0 ]; then
  fail "ledger: found no ledger rows under examples/"
elif [ -s "$tmp/ledger" ]; then
  fail "ledger: $(count "$tmp/ledger") problems ($nrows rows, $nraw raw files)"
  detail "$tmp/ledger"
else
  pass "ledger: $nrows rows match the sha256 of all $nraw raw files"
fi

# 8. The typed sentence reads the same everywhere.
: > "$tmp/sentence"
nsent=0
while IFS= read -r f; do
  grep -H -n -i 'build my ' "$f" > "$tmp/hits" 2>/dev/null || continue
  while IFS= read -r hit; do
    nsent=$((nsent + 1))
    case "$hit" in
      *"$SENTENCE"*) ;;
      *) printf '%s\n' "$hit" | cut -c1-160 >> "$tmp/sentence" ;;
    esac
  done < "$tmp/hits"
done < "$tmp/md"
if [ "$nsent" -eq 0 ]; then
  fail "sentence: the typed sentence appears nowhere"
elif [ -s "$tmp/sentence" ]; then
  fail "sentence: $(count "$tmp/sentence") of $nsent mentions don't read exactly \"$SENTENCE\""
  detail "$tmp/sentence"
else
  pass "sentence: all $nsent mentions read exactly \"$SENTENCE\""
fi

# 9. Each sample wiki's rules keep the same sections as its archetype.
: > "$tmp/sync"
nex=0
for ex in examples/*/AGENTS.md; do
  [ -f "$ex" ] || continue
  nex=$((nex + 1))
  case "$(head -n 1 "$ex")" in
    *"(preserve-tension archetype)"*) overlay=archetypes/preserve-tension-overlay.md ;;
    *) overlay=archetypes/reconcile-overlay.md ;;
  esac
  grep '^## ' "$overlay" > "$tmp/h1"
  grep '^## ' "$ex" > "$tmp/h2"
  cmp -s "$tmp/h1" "$tmp/h2" || echo "$ex: its sections differ from $overlay" >> "$tmp/sync"
done
if [ "$nex" -eq 0 ]; then
  fail "examples: found no sample wiki rules to compare"
elif [ -s "$tmp/sync" ]; then
  fail "examples: a sample wiki's rules have drifted from its archetype"
  detail "$tmp/sync"
else
  pass "examples: $nex sample wiki rules files match their archetype's sections"
fi

echo ""
if [ "$failed" -eq 0 ]; then
  echo "check-kit: all checks passed ($warned warnings)"
  exit 0
fi
echo "check-kit: $failed checks failed ($warned warnings)"
exit 1
