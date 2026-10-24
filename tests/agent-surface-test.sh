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
require_file "CLAUDE.md"
require_file "README.md"
require_file "pyproject.toml"
require_file "rekordbox_mcp/server.py"
require_file "rekordbox_mcp/database.py"
require_file "tests/agent-surface-test.sh"

require_text "AGENTS.md" "Rekordbox"
require_text "AGENTS.md" "backup"
require_text "AGENTS.md" "closed"
require_text "AGENTS.md" "MCP"
require_text "CLAUDE.md" "@AGENTS.md"

printf 'OK rekordbox-mcp agent surfaces\n'
