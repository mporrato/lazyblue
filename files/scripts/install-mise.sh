#!/bin/bash
set -euo pipefail
version=$(curl -fsSLI -o /dev/null -w '%{url_effective}' https://github.com/jdx/mise/releases/latest | sed 's|.*/tag/||')
mkdir -p /usr/local/bin
curl -fsSL "https://github.com/jdx/mise/releases/download/${version}/mise-${version}-linux-x64.tar.gz" | tar xz -C /usr/local/bin --strip-components=2 mise/bin/mise
