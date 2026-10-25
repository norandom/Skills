# Gartner-Inspired Business Palette — Full Specification

Use this palette for boardroom, executive, and compliance-oriented diagrams where a more
authoritative, muted business aesthetic is preferred over the default analytical palette.
This palette is darker and more severe — modeled on Gartner/Forrester/McKinsey-style deliverables.

## When to use

- Board presentations, executive summaries, compliance reports
- Diagrams where the audience expects "serious business" styling
- User explicitly asks for "Gartner look", "business theme", or "executive style"

## Colors

```
BACKGROUND    = #F8FAFC          (unchanged — clean slate)
TITLE         = #0F172A          (near-black navy — authoritative)
SUBTITLE      = #64748B          (slate — secondary, unchanged)

CENTRAL NODE  = #0F172A fill, #020617 stroke, #FFFFFF text
               (very dark navy — the "serious anchor")

CRITICAL      = #991B1B fill, #7F1D1D stroke, #FFFFFF text
               (deep burgundy — regulatory/breach risk)
               Detail text in critical nodes: #FECACA

HIGH          = #B45309 fill, #92400E stroke, #FFFFFF text
               (rich amber — organizational/reputational risk)
               Detail text in high nodes: #FDE68A

MEDIUM        = #6D28D9 fill, #5B21B6 stroke, #FFFFFF text
               (deep violet — operational/strategic risk)
               Detail text in medium nodes: #DDD6FE

LOW           = #64748B fill, #475569 stroke, #FFFFFF text
               (slate — minor concerns)

POSITIVE/SAFE = #D1FAE5 fill, #059669 stroke, #047857 text
               (rarely used in boardroom context — included for completeness)

WARNING       = #FEF3C7 fill, #F59E0B stroke, #B45309 text
               (rarely used in boardroom context — included for completeness)

EDGES         = #94A3B8, strokeWidth=1.5
LEGEND BORDER = #E2E8F0, strokeWidth=1

SHADOWS       = shadow=1 on all primary nodes
               ⚠ RISK: shadow=1 in complex XML can trigger
               "invalid distance too far back" decompression errors.
               Use single-line labels on first render; add details later.
```

## Usage in draw.io XML

```xml
<!-- Title -->
<mxCell style="text;html=1;align=center;fontSize=16;fontColor=#0F172A;fontStyle=1;" .../>

<!-- Central node (ellipse for hub-and-spoke) -->
<mxCell style="ellipse;whiteSpace=wrap;html=1;fillColor=#0F172A;fontColor=#FFFFFF;strokeColor=#020617;strokeWidth=2;fontSize=14;fontStyle=1;" .../>

<!-- Severity-coded spoke node (critical example) -->
<mxCell style="rounded=1;whiteSpace=wrap;html=1;fillColor=#991B1B;fontColor=#FFFFFF;strokeColor=#7F1D1D;fontSize=10;fontStyle=1;" .../>

<!-- High severity -->
<mxCell style="rounded=1;whiteSpace=wrap;html=1;fillColor=#B45309;fontColor=#FFFFFF;strokeColor=#92400E;fontSize=10;fontStyle=1;" .../>

<!-- Medium severity -->
<mxCell style="rounded=1;whiteSpace=wrap;html=1;fillColor=#6D28D9;fontColor=#FFFFFF;strokeColor=#5B21B6;fontSize=10;fontStyle=1;" .../>

<!-- Connector edge -->
<mxCell edge="1" style="endArrow=none;strokeColor=#94A3B8;strokeWidth=1.5;" ...>
  <mxGeometry relative="1" as="geometry"/>
</mxCell>

<!-- Legend dot -->
<mxCell style="rounded=1;whiteSpace=wrap;html=1;strokeColor=none;fillColor=#991B1B;" .../>

<!-- Legend border box -->
<mxCell style="rounded=0;whiteSpace=wrap;html=1;fillColor=none;strokeColor=#E2E8F0;strokeWidth=1;" .../>
```

## Comparison with default palette

| Role | Default | Gartner |
|------|---------|---------|
| Central/primary | #334155 (dark slate) | #0F172A (near-black navy) |
| Critical/negative | #DC2626 (bright red) | #991B1B (deep burgundy) |
| Warning/caution | #F59E0B (amber) | #B45309 (rich amber) |
| Medium/neutral | #8B5CF6 (violet) | #6D28D9 (deep violet) |
| Low/secondary | #64748B (slate) | #64748B (slate, unchanged) |
| Supporting/positive | #059669 (emerald) | Not used in business palette |

The key difference: the business palette is **darker and more severe** — it reads as sober
risk analysis rather than collaborative workshop output. Bright red and bright green are
removed entirely; the remaining colors are all deepened by 1-2 saturation/value steps.
