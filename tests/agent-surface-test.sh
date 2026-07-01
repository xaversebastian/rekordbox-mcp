#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

fail() {
  printf 'FAIL %s\n' "$*" >&2
  exit 1
}

require_file() {
  local path="$1"
  [[ -f "$repo_root/$path" ]] || fail "missing $path"
}

require_text() {
  local path="$1"
  local pattern="$2"
  grep -Eq "$pattern" "$repo_root/$path" || fail "$path missing pattern: $pattern"
}

require_file "AGENTS.md"
require_file "PROJECT_STRUCTURE.md"
require_file "AGENT_HANDOFF.md"
require_file "CLAUDE.md"
require_file "README.md"
require_file "pyproject.toml"
require_file "rekordbox_mcp/server.py"
require_file "rekordbox_mcp/database.py"
require_file "tests/agent-surface-test.sh"

require_text "AGENTS.md" "Codex"
require_text "AGENTS.md" "local LLM"
require_text "AGENTS.md" "Rekordbox"
require_text "AGENTS.md" "approval"
require_text "AGENTS.md" "backup"
require_text "AGENTS.md" "closed"
require_text "AGENTS.md" "MCP"

require_text "PROJECT_STRUCTURE.md" "rekordbox_mcp/server.py"
require_text "PROJECT_STRUCTURE.md" "rekordbox_mcp/database.py"
require_text "PROJECT_STRUCTURE.md" "AGENT_HANDOFF.md"
require_text "PROJECT_STRUCTURE.md" "tests/agent-surface-test.sh"

require_text "AGENT_HANDOFF.md" "STATUS:"
require_text "AGENT_HANDOFF.md" "Changed paths"
require_text "AGENT_HANDOFF.md" "Checks run"
require_text "AGENT_HANDOFF.md" "Open points"

printf 'OK rekordbox-mcp agent surfaces\n'
