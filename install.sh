#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="${HOME}/.gemini/config"
CONFIG_FILE="${CONFIG_DIR}/config.json"
CLI_DIR="${HOME}/.gemini/antigravity-cli"
CLI_SETTINGS="${CLI_DIR}/settings.json"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
POLICY_FILE="${SCRIPT_DIR}/policy.json"

mkdir -p "${CONFIG_DIR}" "${CLI_DIR}"

if [ ! -f "${CONFIG_FILE}" ]; then
  echo "{}" > "${CONFIG_FILE}"
fi

if [ ! -f "${CLI_SETTINGS}" ]; then
  echo "{}" > "${CLI_SETTINGS}"
fi

python3 -c "
import json

config_path = '${CONFIG_FILE}'
policy_path = '${POLICY_FILE}'
cli_path = '${CLI_SETTINGS}'

with open(config_path, 'r') as f:
    try:
        config = json.load(f)
    except Exception:
        config = {}

with open(policy_path, 'r') as f:
    policy = json.load(f)

config.setdefault('userSettings', {})
config['userSettings']['globalPermissionGrants'] = policy['globalPermissionGrants']
config['agentMode'] = 'auto'

with open(config_path, 'w') as f:
    json.dump(config, f, indent=2)
    f.write('\n')

with open(cli_path, 'r') as f:
    try:
        cli_settings = json.load(f)
    except Exception:
        cli_settings = {}

cli_settings['agentMode'] = 'auto'

with open(cli_path, 'w') as f:
    json.dump(cli_settings, f, indent=2)
    f.write('\n')

print('Successfully applied safe command policy to ~/.gemini/config/config.json')
print('Successfully configured agentMode: \"auto\" in ~/.gemini/antigravity-cli/settings.json')
"
