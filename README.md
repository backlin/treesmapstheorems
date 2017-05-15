Trees, Maps, and Theorems
=========================
An R package with themes for `ggplot2` following the principles in
[Trees, maps, and theorems][tmt].

`ggplot2` is an excellent graphics library but the plots it produces require a
lot of manual styling to look clean and clutter free.
This package provides a collection of themes that take care of that for you.

Installation
------------
```
library(devtools)
install_github("backlin/treesmapstheorems")
```

Examples
--------
The current package comes with these four standard themes out of the box.
It also contains a function `tmt_theme` that lets you create custom ones
in case you want to tweak small stuff.
The documentation for it is not yet comprehensive so you have
to look at the existing themes and source code to explore the options.

### Bar plots
Left hand side shows the default theme and the right hand size shows the
TMT themes.

![Bar plots][bar-plots]

### Line plots
Top left shows the default theme and the other panels shows the
TMT themes.

![Line plots][line-plots]

[tmt]: http://www.treesmapsandtheorems.com
[bar-plots]: https://github.com/backlin/treesmapstheorems/blob/graphics/plots/bar_plots.png
[line-plots]: https://github.com/backlin/treesmapstheorems/blob/graphics/plots/line_plots.png
