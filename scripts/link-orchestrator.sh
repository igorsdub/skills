#!/usr/bin/env bash
set -euo pipefail

# Personal installer for the orchestrator policy. Not part of the plugin.
# Sibling of link-skills.sh. Links the global rules files and the sub-agent
# definitions from this repo into the local harness config dirs:
#   - ~/.claude/CLAUDE.md, ~/.claude/agents/*.md: Claude Code
#   - ~/.gemini/GEMINI.md: Gemini CLI and Antigravity
#   - ~/.codex/AGENTS.md: Codex CLI
# Existing real files are never overwritten; merge or remove them yourself.
#
# Usage: link-orchestrator.sh [--copy-agents]
#   --copy-agents  copy agents instead of symlinking (fallback if Claude Code
#                  ignores symlinked agents)
#
# Note: ~/.codex/AGENTS.md is the conventional Codex global path but was not
# confirmed in the official docs consulted.

REPO="$(cd "$(dirname "$0")/.." && pwd)"
COPY=0
[ "${1:-}" = "--copy-agents" ] && COPY=1

status=0

link_rule() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "skipped $dest: a real file exists. Merge it into $src or remove it, then re-run." >&2
    status=1
    return
  fi
  ln -sfn "$src" "$dest"
  echo "linked $dest -> $src"
}

link_rule "$REPO/rules/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
link_rule "$REPO/rules/GEMINI.md" "$HOME/.gemini/GEMINI.md"
link_rule "$REPO/rules/AGENTS.md" "$HOME/.codex/AGENTS.md"

AGENTS_DEST="$HOME/.claude/agents"
mkdir -p "$AGENTS_DEST"

for f in "$AGENTS_DEST"/*; do
  [ -L "$f" ] || continue
  if [ ! -e "$f" ]; then
    target="$(readlink "$f")"
    case "$target" in
      /*) ;;
      *) target="$AGENTS_DEST/$target" ;;
    esac
    case "$target" in
      "$REPO"/*)
        rm "$f"
        echo "cleaned stale symlink $(basename "$f")"
        ;;
    esac
  fi
done

for src in "$REPO"/agents/*.md; do
  [ -e "$src" ] || continue
  target="$AGENTS_DEST/$(basename "$src")"
  if [ "$COPY" -eq 1 ]; then
    [ -L "$target" ] && rm "$target"
    cp "$src" "$target"
    echo "copied $(basename "$src") -> $AGENTS_DEST"
  else
    if [ -e "$target" ] && [ ! -L "$target" ]; then
      rm -f "$target"
    fi
    ln -sfn "$src" "$target"
    echo "linked $(basename "$src") -> $src ($AGENTS_DEST)"
  fi
done

cat <<'MSG'

Optional (not applied): hard-block sub-agent nesting in Claude Code with
  f=~/.claude/settings.json; [ -f "$f" ] || echo '{}' > "$f"; jq '.env.CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH="1"' "$f" > "$f.tmp" && mv "$f.tmp" "$f"
MSG

exit "$status"
