# MCP servers

Prebuilt `.mcpb` bundles for Claude Desktop, with sources so you can rebuild or fork.

## Bundles

### `drawio-remote.mcpb` — draw.io (Remote)

Lets Claude Desktop talk to a remote draw.io MCP server over Streamable HTTP. There's no local server in the bundle; it just spawns `npx mcp-remote <url>` and forwards stdio to the remote `/mcp` endpoint.

Default endpoint: `https://drawmcp.because-security.com/mcp`. Sources: [`drawio-remote/`](./drawio-remote).

#### Install

Double-click `drawio-remote.mcpb`, or drag it into Claude Desktop → Settings → Extensions. Accept the default endpoint, or paste your own URL into **Remote MCP URL**. The URL must include the `/mcp` path — `https://drawmcp.example.com/mcp`, `http://localhost:3000/mcp` for a local instance, whatever you're running. No rebuild needed; the URL is user config.

#### Rebuild from source

Sources are in [`drawio-remote/`](./drawio-remote). To rebuild:

```bash
cd mcp_servers
npx -y @anthropic-ai/mcpb pack drawio-remote drawio-remote.mcpb
```

That validates `manifest.json` against the MCPB schema and zips the directory. The `.mcpb` format is a zip, so `cd drawio-remote && zip -r ../drawio-remote.mcpb .` works if you'd rather skip the packer.

To change the baked-in default endpoint, edit `drawio-remote/manifest.json` → `user_config.server_url.default` and rerun the pack. Bump `version` in the same commit.

#### Install into non-Claude-Desktop tools

`install_drawio.sh` registers the same drawio MCP server (`npx -y mcp-remote <url>`) across every other tool you use, so you don't have to hand-edit each config:

```bash
./install_drawio.sh             # auto-detect: try every supported tool
./install_drawio.sh --claude --codex
./install_drawio.sh --dry-run
./install_drawio.sh --url https://my-drawio.example.com/mcp
./install_drawio.sh --uninstall --all
```

Targets and how they're modified:

| Flag | Tool | Mechanism |
| ---- | ---- | --------- |
| `--claude` | Claude Code | `claude mcp add drawio -- npx -y mcp-remote <url>` |
| `--gemini` | Gemini CLI | `gemini mcp add -s user drawio npx -y mcp-remote <url>` |
| `--codex` | Codex CLI | `codex mcp add drawio -- npx -y mcp-remote <url>` |
| `--hermes` | Hermes | `~/.hermes/config.yaml` (`mcp_servers` key) edited via `yq` |
| `--opencode` | opencode | `~/.config/opencode/opencode.json` (`mcp` key) edited via `jq` |
| `--deepseek` | DeepSeek TUI | `deepseek mcp add ...` (CLI); script also patches `connect_timeout` to 60s |
| `--all` | every target above | only tools whose CLI or home dir exists are touched |

Requirements: `jq` (always), `yq` v4+ from mikefarah (only when `--hermes` is in play; install with `brew install yq`). The script never overwrites unrelated entries — CLI tools manage their own state, `jq`/`yq` do an in-place merge keyed by server name.

DeepSeek note: the drawio endpoint runs `npx -y mcp-remote`, which does an OAuth-discovery handshake that routinely takes 12–15s on a cold cache. DeepSeek's MCP `connect_timeout` defaults to 10s, so the script patches `~/.deepseek/mcp.json` → `servers.drawio.connect_timeout = 60` after registration. If you bump the global default elsewhere, the per-server override still wins.

Claude Desktop is intentionally not a target — for it, use the prebuilt `.mcpb` above; that flow already exposes a UI prompt for the URL.
