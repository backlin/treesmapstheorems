#!/bin/sh

R -f render_manual.R
R CMD build .
ls -t treesmapstheorems_*.tar.gz | head -1 | xargs R CMD check
