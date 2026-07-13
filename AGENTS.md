# AGENTS.md - rekordbox-mcp

This file is the tool-agnostic maintenance contract for this repo. The product
is an MCP server with direct Rekordbox database access, so repo maintenance
must stay separate from live library reads and writes.

## Session Start

1. Read this file.
2. Read `PROJECT_STRUCTURE.md`.
3. Read `AGENT_HANDOFF.md`.
4. Read `README.md` and `pyproject.toml` before behavior changes. Read
   `CLAUDE.md` only when Claude was explicitly selected.
5. Check `git status --short --branch` before edits and do not touch foreign
   dirty changes.

## Scope

- `rekordbox_mcp/server.py` defines the FastMCP tools and server entry point.
- `rekordbox_mcp/database.py` wraps pyrekordbox database access and mutations.
- `rekordbox_mcp/models.py` contains Pydantic models.
- `tests/` contains mocked tests; these must not require a real Rekordbox
  library.
- `CLAUDE.md` is a Claude-specific adapter. It is useful context, not a
  required runtime for Codex or local LLM maintenance.
- `AGENT_HANDOFF.md` records current repo maintenance state.

## Agent Roles

- Codex is the default coding agent for complete, clearly scoped reversible
  repo tasks; task size alone does not require another tool.
- Claude-specific MCP usage is product-facing behavior, not a maintenance
  requirement.
- A local LLM must be able to work from files in this order:
  `AGENTS.md` -> `PROJECT_STRUCTURE.md` -> `AGENT_HANDOFF.md` -> `README.md`
  -> `pyproject.toml`.

## Safety Rules

- Do not start the MCP server, run `setup-key.py`, connect to a real Rekordbox
  database, read media/library paths, or edit Claude/MCP client config without
  explicit approval in the current task.
- Do not perform write or destructive bridge actions unless the current task
  explicitly approves the action, a backup plan is stated, and Rekordbox is
  confirmed closed.
- Do not read `.env*`, token stores, database files, backups, exports,
  screenshots, media files, or credentials.
- Minimal justified repo dependency changes are allowed with manifest,
  lockfile and mocked checks. Client installation, Docker/runtime changes,
  publishing, package releases and external sync require explicit approval.
- Keep changes scoped and atomic. Preserve the distinction between product
  docs in `README.md`, Claude-specific guidance in `CLAUDE.md`, and
  maintenance rules in this file.
- Generated/vendor areas and `.git` internals are count/classify-only unless
  explicitly targeted.

## Checks

Focused maintenance check:

```bash
tests/agent-surface-test.sh
```

For Python edits, prefer the mocked suite and static checks that do not touch a
real Rekordbox database. If lint/type checks fail on pre-existing baseline
debt, report that clearly instead of weakening checks:

```bash
uv run --extra dev pytest tests/ -v
uv run --extra dev ruff check rekordbox_mcp/
uv run --extra dev mypy rekordbox_mcp/
```

For shell edits, run `bash -n` on changed shell scripts.

## Handoff Updates

Append only for durable cross-session state, open gates, or a real handoff:

- Date, tool, one-line goal
- Changed paths
- Checks run
- Open points
- Uncertain assumptions
- Alternatives rejected
