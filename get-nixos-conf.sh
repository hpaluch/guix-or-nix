#!/bin/bash
set -xeuo pipefail
cd `dirname $0`
# TODO: replace with rsync later...
scp nixos-home:/etc/nixos/*.nix nixos/
exit 0
