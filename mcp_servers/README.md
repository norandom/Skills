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
