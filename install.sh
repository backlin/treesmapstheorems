#!/bin/sh

# Build package archive
my_dir="$(dirname "$0")"
"$my_dir/build.sh"

# Install
ls -t treesmapstheorems_*.tar.gz | head -1 | xargs R CMD install
