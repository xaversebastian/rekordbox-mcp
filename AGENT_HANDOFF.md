# Agent Handoff - rekordbox-mcp

STATUS: LIVE - 2026-07-01 - repo handoff for Codex, Claude, and local LLM agents

## Purpose

This file records current maintenance state for `tools/rekordbox-mcp`. It is
append-only for substantial sessions. Do not paste chat transcripts, secrets,
credentials, database contents, backups, exports, screenshots, media-library
data, or local Rekordbox state.

## Current State

- `rekordbox-mcp` is a Python FastMCP server for Rekordbox database access.
- `rekordbox_mcp/server.py` defines MCP tools and resources.
- `rekordbox_mcp/database.py` wraps pyrekordbox access and mutation behavior.
- `README.md` documents explicit backup, risk, and write-operation warnings.
- `CLAUDE.md` is the Claude-specific adapter and architecture summary.
- Repo maintenance should work file-first through `AGENTS.md`,
  `PROJECT_STRUCTURE.md`, and this handoff before product files are edited.
- No repo-local Codex hook surface, CI, release automation, or local MCP config
  is documented here yet.
- Current baseline note: the mocked pytest suite passes, while `ruff check` and
  `mypy` currently fail on pre-existing product-code issues. Do not repair that
  as part of an agent-surface package.

## Update Rule

For substantial work, append:

- Date, tool, one-line goal
- Changed paths
- Checks run
- Open points
- Uncertain assumptions
- Alternatives rejected

## Chronological Log

### 2026-07-01 - Codex - initial agent surfaces

- **Goal:** Add file-first repo surfaces so Codex and local LLM agents can
  maintain the Rekordbox MCP bridge without requiring Claude memory, MCP client
  config, real Rekordbox database access, key setup, or server startup.
- **Changed paths:**
  - `AGENTS.md`
  - `PROJECT_STRUCTURE.md`
  - `AGENT_HANDOFF.md`
  - `tests/agent-surface-test.sh`
- **Checks run:** See final package report in the workspace/root handoff for
  the full verification bundle.
- **Open points:** No MCP server run, `setup-key.py` run, real Rekordbox
  database connection, library/media/export read, Claude client config edit,
  Docker build, release, publish, push, or bridge write was performed.
- **Baseline check debt:** `uv run --extra dev ruff check rekordbox_mcp/` and
  `uv run --extra dev mypy rekordbox_mcp/` fail on pre-existing product-code
  issues. This package did not touch product code.
- **Uncertain assumptions:** This package should document repo maintenance and
  approval gates only; MCP behavior and product docs remain unchanged.
- **Alternatives rejected:** No product-code changes, no live bridge test, no
  external app write, no real database fixture, and no broad tools repo sweep.
