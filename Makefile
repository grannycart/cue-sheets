# Makefile
# Last modified: Wed Oct 26, 2022  02:44PM
#################################################################################
# Requires: pandoc latex columns.lua
#
# This is the built files directory, all output files will be created in here:
BUILD = built-files
# This FILENAME variable is the output file name:
FILENAME = cue-sheet-example-formatted
# This is the name of the (input) markdown version of your cue sheet:
CUE_SHEET = cue-sheet-example.md
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
#	Below: The -s flag is standalone.
#	The --self-contained tells pandoc to include the css in the html file, rather than just referencing it.
	pandoc -s --css=$(CSS) --self-contained $(DATE) --from markdown+smart --to=html5 -o $@ $^

$(BUILD)/pdf/$(FILENAME).pdf: $(CUE_SHEET)
	mkdir $(BUILD)/pdf
#	Below with some latex options (-V) added.
#		-V pagestyle=empty turns off page numbers (maybe doesn't work with multi-page documents)
#		Other options you might want to try:  -V classoption:twocolumn
#	columns lua filter gives some capabilities for multicols. The syntax for style and where the columns are is written into the markdown on the lines beginning with :::.
	pandoc -s --from markdown+smart --pdf-engine=xelatex $(DATE) --lua-filter="./columns.lua" -V pagestyle=empty -V documentclass=$(LATEX_CLASS) -V classoption:landscape -V papersize=letter -V geometry:margin=.5in -o $@ $^

.PHONY: all book clean html pdf
