R-files := $(shell find R -type f)
version := $(shell grep -r "Version" DESCRIPTION | cut -c 22-)
pkg := treesmapstheorems_$(version).tar.gz

build: $(pkg)
	@echo "Built $<"

$(pkg): $(R-files) render_manual.R
	R -f render_manual.R
	R CMD build .

check: $(pkg)
	R CMD check $<

install: $(pkg)
	R CMD install $<

