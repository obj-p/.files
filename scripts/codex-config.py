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
updated = source
changed = []

for table, key, label in (
    ("analytics", "enabled", "anonymous Codex usage metrics"),
    ("tui", "animations", "Codex terminal animations"),
):
    settings = config.get(table, {})
    if not isinstance(settings, dict):
        sys.exit(f"Expected {table} to be a TOML table. Config was not changed.")

    if settings.get(key) is False:
        continue

    config.setdefault(table, {})[key] = False
    section = re.search(rf"(?m)^[ \t]*\[{table}\][ \t]*(?:#[^\n]*)?$", updated)

    if section:
        start = section.end()
        next_section = re.search(r"(?m)^[ \t]*\[", updated[start:])
        end = start + next_section.start() if next_section else len(updated)
        body = updated[start:end]
        body, count = re.subn(
            rf"(?m)^([ \t]*{key}[ \t]*=[ \t]*)(true|false)\b",
            r"\g<1>false",
            body,
            count=1,
        )
        if not count:
            body = f"\n{key} = false" + (body or "\n")
        updated = updated[:start] + body + updated[end:]
    else:
        updated, count = re.subn(
            rf"(?m)^([ \t]*{table}\.{key}[ \t]*=[ \t]*)(true|false)\b",
            r"\g<1>false",
            updated,
            count=1,
        )
        if not count:
            updated = updated.rstrip("\n") + f"\n\n[{table}]\n{key} = false\n"
            if not source:
                updated = updated.lstrip("\n")
    changed.append(label)

if not changed:
    print(f"Anonymous Codex usage metrics and terminal animations are already disabled in {path}.")
    sys.exit(0)

try:
    valid = tomllib.loads(updated) == config
except tomllib.TOMLDecodeError:
    valid = False

if not valid:
    sys.exit("Could not safely update Codex settings. Config was not changed.")

path.parent.mkdir(parents=True, exist_ok=True)
path.write_text(updated)
print(f"Disabled {' and '.join(changed)} in {path}. Restart Codex to apply.")
