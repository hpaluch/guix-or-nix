#!/bin/bash
set -xeuo pipefail
cd `dirname $0`
# TODO: replace with rsync later...
scp guix-home:/etc/config.scm guix/
exit 0
