# Makefile
# Last modified: 2024-01-14 18:36
#################################################################################
# Requires: pandoc latex columns.lua
#
# This is the built files directory, all output files will be created in here:
BUILD = built-files
# This FILENAME variable is the output file name:
FILENAME = cue-sheet-formatted
# This is the name of the (input) markdown version of your cue sheet, edit to match the filename of the cue sheet you want to make a pdf of:
CUE_SHEET = cue-sheets/cue-sheet-example.md
LATEX_CLASS = article
# This corresponds to the --css switch in the pandoc command:
CSS = css/clean-html.css
# This line puts a version date into the compiled pandoc file using the -M metadata switch. The default setup puts in today's date:
DATE = -M date="Version date - `date "+%B %e, %Y"`" 

all: html pdf

clean:
	rm -rfd $(BUILD)

html: $(BUILD)/html/$(FILENAME).html

pdf: $(BUILD)/pdf/$(FILENAME).pdf

hand-formatted: $(BUILD)/hand-pdf/$(FILENAME).pdf

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
#		Other options you might want to try:  -V classoption:twocolumn -V classoption:landscape
	pandoc -s --from markdown+smart --pdf-engine=xelatex $(DATE) --lua-filter="./columns/columns.lua" -V pagestyle=empty -V documentclass=$(LATEX_CLASS) -V classoption:portrait -V papersize=letter -V geometry:margin=.5in -o $@ ./columns/columns-format-prepend.md  $^ ./columns/columns-format-append.md

$(BUILD)/hand-pdf/$(FILENAME).pdf: $(CUE_SHEET)
	mkdir $(BUILD)/hand-pdf
# 	pandoc command notes:
# 	This is just the same line as the pdf target, but without the formatting files prepended and appended.
# 	The idea is you could put those formatting lines into the markdown file by hand,
# 	if you want them somewhere other than the beginning and end.
# 	Try it with the cue sheets in the cue-sheets/ directory that have commentary at the beginning
# 	If you don't make any further edits to a plain markdown file, this will just
# 	turn out the cues formatted for a full sheet of paper.
	pandoc -s --from markdown+smart --pdf-engine=xelatex $(DATE) --lua-filter="./columns/columns.lua" -V pagestyle=empty -V documentclass=$(LATEX_CLASS) -V classoption:portrait -V papersize=letter -V geometry:margin=.5in -o $@ $^ 



.PHONY: all book clean html pdf hand-formatted
