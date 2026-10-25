"""Shared credential redaction for scanner JSON, logs, and CI summaries."""

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
    text = re.sub(r"(?i)((?:x-api-key|api[_-]?key|authorization|access[_-]?token)\s*[\"']?\s*[:=]\s*)[^\r\n,}]+", r"\1[REDACTED]", text)
    # Remove terminal controls and GitHub workflow-command prefixes from logs.
    text = re.sub(r"\x1b\[[0-?]*[ -/]*[@-~]", "", text)
    text = re.sub(r"(?m)^::", "[workflow-command] ", text)
    return text


def redact_json(value):
    if isinstance(value, dict):
        return {
            redact(str(key)): "[REDACTED]" if re.search(
                r"(?i)^(?:authorization|x-api-key|api[_-]?key|access[_-]?token|secret)$", str(key)
            ) else redact_json(item)
            for key, item in value.items()
        }
    if isinstance(value, list):
        return [redact_json(item) for item in value]
    return redact(value) if isinstance(value, str) else value


if __name__ == "__main__":
    try:
        text = Path(sys.argv[1]).read_text(encoding="utf-8", errors="replace")
        print(redact(text))
    except OSError:
        print("Scanner diagnostics unavailable.")
