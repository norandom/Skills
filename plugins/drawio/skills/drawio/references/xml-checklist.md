# Draw.io XML Generation Checklist

Check EVERY item before calling `mcp_drawio_open_drawio_xml`.

## Hard Blockers (server rejects with `isError=true`)

1. **NO `shadow=1`** on any node. Causes "invalid distance too far back" error.
2. **NO nested HTML** in value attributes (no `<font>`, `<br>` inside values). Use `&#xa;` for line breaks. Prefer `fontStyle=1` over inline font tags.
3. **NO unescaped `&`** in attribute values — always use `&amp;`. Bare `&` corrupts URL encoding (atob/base64 pipeline).
4. **Every edge cell** (`edge="1"`) MUST contain `<mxGeometry relative="1" as="geometry"/>` as a child element.
5. **Structural cells required**: `<mxCell id="0"/>` and `<mxCell id="1" parent="0"/>` must exist in every diagram.
6. **All cell IDs must be unique.**
7. **Every cell needs `html=1`** attribute.

## XML Well-Formedness

8. **NO XML comments** (`<!-- -->`) — strictly forbidden.
9. **Unique IDs** — no duplicates across any cell.
10. **Source/target attributes** on edges must reference valid existing cell IDs.

## Recovery

If diagram fails with "invalid distance too far back":
- Regenerate WITHOUT `shadow=1` on any node
- Keep all value attributes as plain text only (no nested HTML)
