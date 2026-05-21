#!/bin/bash
set -xeuo pipefail
cd `dirname $0`
# TODO: replace with rsync later...
rsync -avi --include='*.nix' nixos-home:/etc/nixos/ nixos/
exit 0
