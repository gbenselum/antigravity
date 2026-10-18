#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="${HOME}/.gemini/config"
CONFIG_FILE="${CONFIG_DIR}/config.json"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
POLICY_FILE="${SCRIPT_DIR}/policy.json"

mkdir -p "${CONFIG_DIR}"

if [ ! -f "${CONFIG_FILE}" ]; then
  echo "{}" > "${CONFIG_FILE}"
fi

python3 -c "
import json

config_path = '${CONFIG_FILE}'
policy_path = '${POLICY_FILE}'

with open(config_path, 'r') as f:
    try:
        config = json.load(f)
    except Exception:
        config = {}

with open(policy_path, 'r') as f:
    policy = json.load(f)

config.setdefault('userSettings', {})
config['userSettings']['globalPermissionGrants'] = policy['globalPermissionGrants']

with open(config_path, 'w') as f:
    json.dump(config, f, indent=2)
    f.write('\n')

print('Successfully applied safe command policy to ~/.gemini/config/config.json')
"
