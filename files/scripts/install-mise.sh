#!/bin/bash
set -euo pipefail
curl -fsSL https://mise.run | MISE_INSTALL_PATH="/usr/bin/mise" bash
echo 'eval "$(/usr/bin/mise activate $(readlink /proc/$$/exe | awk -F/ "{print \$NF}"))"' > /etc/profile.d/mise.sh
