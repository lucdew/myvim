#!/bin/bash
set -e
set -o pipefail

plugins=$(git  submodule --quiet foreach bash -c "echo -e \"* [\$(git config --get remote.origin.url | sed 's#https://##' | sed 's#git://##' | sed 's/.git//')](\$(git config --get remote.origin.url))\"")

sed  -i '/## Plugins/,$d' README.md
echo -e "## Plugins\n\n$plugins" >> README.md
