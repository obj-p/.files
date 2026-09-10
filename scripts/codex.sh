#!/usr/bin/env bash

set -euo pipefail

curl -fsSL https://chatgpt.com/codex/install.sh | sh

python3 "$(dirname "${BASH_SOURCE[0]}")/codex-config.py"

echo
echo "Run 'codex login' to authenticate Codex."
