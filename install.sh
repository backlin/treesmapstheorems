#!/bin/sh

ls -t treesmapstheorems_*.tar.gz | head -1 | xargs R CMD INSTALL
