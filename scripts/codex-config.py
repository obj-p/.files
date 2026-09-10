import os
import re
import sys
from pathlib import Path

if sys.version_info < (3, 11):
    sys.exit("Codex configuration requires Python 3.11 or newer.")

import tomllib

path = Path(os.environ.get("CODEX_HOME") or "~/.codex").expanduser() / "config.toml"
source = path.read_text() if path.exists() else ""
config = tomllib.loads(source)
analytics = config.get("analytics", {})

if not isinstance(analytics, dict):
    sys.exit("Expected analytics to be a TOML table. Config was not changed.")

if analytics.get("enabled") is False:
    print(f"Anonymous Codex usage metrics are already disabled in {path}.")
    sys.exit(0)

config.setdefault("analytics", {})["enabled"] = False
section = re.search(r"(?m)^[ \t]*\[analytics\][ \t]*(?:#[^\n]*)?$", source)

if section:
    start = section.end()
    next_section = re.search(r"(?m)^[ \t]*\[", source[start:])
    end = start + next_section.start() if next_section else len(source)
    body = source[start:end]
    body, count = re.subn(
        r"(?m)^([ \t]*enabled[ \t]*=[ \t]*)(true|false)\b",
        r"\g<1>false",
        body,
        count=1,
    )
    if not count:
        body = "\nenabled = false" + (body or "\n")
    updated = source[:start] + body + source[end:]
else:
    updated, count = re.subn(
        r"(?m)^([ \t]*analytics\.enabled[ \t]*=[ \t]*)(true|false)\b",
        r"\g<1>false",
        source,
        count=1,
    )
    if not count:
        updated = source.rstrip("\n") + "\n\n[analytics]\nenabled = false\n"
        if not source:
            updated = updated.lstrip("\n")

try:
    valid = tomllib.loads(updated) == config
except tomllib.TOMLDecodeError:
    valid = False

if not valid:
    sys.exit("Could not safely update analytics.enabled. Config was not changed.")

path.parent.mkdir(parents=True, exist_ok=True)
path.write_text(updated)
print(f"Disabled anonymous Codex usage metrics in {path}. Restart Codex to apply.")
