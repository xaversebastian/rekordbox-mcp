# PROJECT_STRUCTURE.md - rekordbox-mcp

`rekordbox-mcp` is a Python FastMCP server for Rekordbox database access. It
can expose read, write, import, cleanup, and destructive operations, so ordinary
repo maintenance must avoid live database access unless a task explicitly
approves it.

## Start Here

1. `AGENTS.md` - repo maintenance rules and approval gates.
2. `PROJECT_STRUCTURE.md` - this file index.
3. `AGENT_HANDOFF.md` - current status and open points.
4. `README.md` - public setup, safety notice, and usage guide.
5. `CLAUDE.md` - Claude-specific adapter and architecture notes.
6. `pyproject.toml` - Python package metadata and tool config.

## Tree

```text
rekordbox-mcp/
|-- AGENTS.md                    # Tool-agnostic repo maintenance rules
|-- AGENT_HANDOFF.md             # Append-only repo handoff
|-- CLAUDE.md                    # Claude Code adapter and architecture notes
|-- LICENSE                      # MIT license
|-- PROJECT_STRUCTURE.md         # This file-first index
|-- README.md                    # Public overview, setup, and safety guide
|-- export_genre_to_zip.py       # Utility script; avoid media/export reads unless scoped
|-- glama.json                   # MCP marketplace metadata
|-- main.py                      # Compatibility entry point
|-- pyproject.toml               # Package metadata and test/tool config
|-- rekordbox_mcp/
|   |-- __init__.py              # Package marker
|   |-- database.py              # pyrekordbox database wrapper
|   |-- models.py                # Pydantic models
|   `-- server.py                # FastMCP server and tool definitions
|-- run-server.sh                # Server launcher; do not run without approval
|-- setup-key.py                 # Key setup helper; do not run without approval
|-- tests/
|   |-- agent-surface-test.sh    # Verifies required agent surfaces
|   |-- conftest.py              # Test fixtures
|   |-- test_caching.py          # Mocked caching tests
|   |-- test_database.py         # Mocked database-layer tests
|   |-- test_models.py           # Model tests
|   `-- test_server.py           # Mocked server tests
`-- uv.lock                      # Dependency lockfile
```

## Ownership Boundaries

- MCP tool behavior lives in `rekordbox_mcp/server.py`.
- Database access and mutation safety live in `rekordbox_mcp/database.py`.
- Public safety and install guidance live in `README.md`.
- Claude-specific repo notes live in `CLAUDE.md`.
- Agent maintenance rules live in `AGENTS.md`.
- Current repo state lives in `AGENT_HANDOFF.md`.

Do not hide product behavior changes in maintenance docs. Do not turn
always-on instructions into a changelog.

## Exclusions

Do not content-audit or ingest:

- `.git/`
- `.env*` files or credential stores
- `node_modules/`
- `.venv/`, `__pycache__/`
- `dist/`, `build/`, generated outputs
- Rekordbox database files, backups, exports, media libraries, screenshots, or
  local app state

Allowed checks for excluded paths: existence, counts, sizes, and classification.

## Verification

Focused maintenance check:

```bash
tests/agent-surface-test.sh
```

For Python edits, use mocked/static checks that do not connect to a real
database:

```bash
uv run --extra dev pytest tests/ -v
uv run --extra dev ruff check rekordbox_mcp/
uv run --extra dev mypy rekordbox_mcp/
```
