#!/bin/bash
set -euo pipefail
curl -fsSL https://mise.run | MISE_INSTALL_PATH="/usr/local/bin/mise" bash
echo 'eval "$(/usr/local/bin/mise activate $(readlink /proc/$$/exe | awk -F/ "{print \$NF}"))"' > /etc/profile.d/mise.sh
