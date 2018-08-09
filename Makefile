source_files := $(shell git ls-files)
version := $(shell grep -r "Version" DESCRIPTION | cut -c 22-)
pkg := treesmapstheorems_$(version).tar.gz

build: $(pkg)
	@echo "Built $<"

$(pkg): $(source_files)
	R -f render_manual.R
	R CMD build .

check: $(pkg)
	R CMD check $<

install: $(pkg)
	R CMD install $<

