# AGENTS.md - rekordbox-mcp

MCP server with direct Rekordbox database access (FastMCP, pyrekordbox). Aufbau,
Befehle und Sicherheitshinweise: `README.md`, `pyproject.toml`. Code in
`rekordbox_mcp/` (`server.py` Tools, `database.py` Zugriff, `models.py`);
`tests/` sind gemockt und brauchen keine echte Bibliothek.

## Rules

- Write or destructive bridge actions (playlists, import, cleanup) only with a
  stated backup and Rekordbox closed; read-only tools work while it is open.
  Irreversible deletion is question class 1.
- BPM is stored as int times 100 (12800 = 128.0). Smart playlists cannot be deleted.
- `setup-key.py` never prints key values.
