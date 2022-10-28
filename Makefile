# Makefile
# Last modified: Fri Oct 28, 2022  10:44AM
#################################################################################
# Requires: pandoc latex columns.lua
#
# This is the built files directory, all output files will be created in here:
BUILD = built-files
# This FILENAME variable is the output file name:
FILENAME = cue-sheet-formatted
# This is the name of the (input) markdown version of your cue sheet:
CUE_SHEET = cue-sheet-example.md
# This is anothe cue sheet you could try, uncomment below line, comment above:
# CUE_SHEET = cue-sheets/RandallsIsland-to-CityIsland.md
LATEX_CLASS = article
# This corresponds to the --css switch in the pandoc command:
CSS = css/clean-html.css
# This line puts a version date into the compiled pandoc file using the -M metadata switch. The default setup puts in today's date:
DATE = -M date="Version date - `date "+%B %e, %Y"`" 

all: html pdf

clean:
	rm -r $(BUILD)

html: $(BUILD)/html/$(FILENAME).html

pdf: $(BUILD)/pdf/$(FILENAME).pdf

$(BUILD)/html/$(FILENAME).html: $(CUE_SHEET)
	mkdir -p $(BUILD)/html
# 	pandoc command notes:
#	The -s flag is standalone.
#	The --self-contained tells pandoc to include the css in the html file, rather than just referencing it.
	pandoc -s --css=$(CSS) --self-contained $(DATE) --from markdown+smart --to=html5 -o $@ $^

$(BUILD)/pdf/$(FILENAME).pdf: $(CUE_SHEET)
	mkdir $(BUILD)/pdf
# 	pandoc command notes:
#	columns lua filter gives some capabilities for multicols. See README and columns/columns-format-append.md for details
#	pandoc concatenates input files together, so the colunmns-format files contain the columns lua filter configuration that gets added before the the main cue sheet markdown (contained in the automatic make variable $^) and then after for the closing formatting for the columns.
#	some latex options (-V) added:
#		-V pagestyle=empty turns off page numbers (maybe doesn't work with multi-page documents)
#		Other options you might want to try:  -V classoption:twocolumn
	pandoc -s --from markdown+smart --pdf-engine=xelatex $(DATE) --lua-filter="./columns/columns.lua" -V pagestyle=empty -V documentclass=$(LATEX_CLASS) -V classoption:landscape -V papersize=letter -V geometry:margin=.5in -o $@ ./columns/columns-format-prepend.md  $^ ./columns/columns-format-append.md

.PHONY: all book clean html pdf
