"""Print bounded scanner diagnostics with credential redaction for CI."""

import os
from pathlib import Path
import re
import sys


def redact(text: str) -> str:
    for name, value in os.environ.items():
        if value and any(part in name.upper() for part in ("API_KEY", "TOKEN", "SECRET")):
            text = text.replace(value, "[REDACTED]")
    text = re.sub(r"sk-[A-Za-z0-9_-]+", "[REDACTED]", text)
    text = re.sub(r"(?i)(bearer\s+)\S+", r"\1[REDACTED]", text)
    return text


if __name__ == "__main__":
    try:
        text = Path(sys.argv[1]).read_text(encoding="utf-8", errors="replace")
        print("---- sanitized scanner diagnostics (last 40 lines) ----")
        print("\n".join(redact(text).splitlines()[-40:])[-12000:])
    except OSError:
        print("Scanner diagnostics unavailable.")
