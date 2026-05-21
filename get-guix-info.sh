#!/bin/bash
set -xeuo pipefail
cd `dirname $0`
# TODO: replace with rsync later...
ssh -t guix-home sudo herd status | tee guix/herd-status.txt
exit 0
