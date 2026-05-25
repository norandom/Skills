# Blindspot-from-Premortem Diagram Pattern

Derive a blindspot diagram from a premortem analysis.

## Structure
- **Central node** (red, bold) = the hidden assumption uncovered by the premortem
- **Direct dependents** (red outline) = failures that cascade if the blindspot fails
- **Partial dependents** (amber outline) = vulnerable alone, but don't cascade
- **Process assumptions** (grey) = procedural beliefs that hid the blindspot
- **"justifies" edge** (dashed): from process assumption → blindspot node

## Example (from real-options session)
- Central: "Cooperation = Comprehension" (assumption that cooperating means understanding)
- Process assumption: "Legal documents prove informed consent"
