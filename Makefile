# Makefile
# Last modified: Fri Oct 28, 2022  07:47AM
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

$(BUILD)/html/$(FILENAME).html: html-$(CUE_SHEET)
	mkdir -p $(BUILD)/html
#	Below: The -s flag is standalone.
#	The --self-contained tells pandoc to include the css in the html file, rather than just referencing it.
#	This is currently set to run on a copy of the cue sheet file prepended by html- (see line 29)
#	The copy has the ::: {columns (etc) lines removed so pandoc doesn't interpret those to mean the file should have three columns
#		(Something you probably don't want for html)
#	It would be cool to add commands that stripped those lines out of the markdown files automatically
#		Actually, it should be the other way around -- start with a clean md and add the column formatting line to the beginning.
#		Then compile for pdf with that line in place (add closing ::: too)
#		Maybe add a third make target that allows you to place the columns line manually (for middle of file placements)
#			keep that one out of make all though
	pandoc -s --css=$(CSS) --self-contained $(DATE) --from markdown+smart --to=html5 -o $@ $^

$(BUILD)/pdf/$(FILENAME).pdf: $(CUE_SHEET)
	mkdir $(BUILD)/pdf
#	Below with some latex options (-V) added.
#		-V pagestyle=empty turns off page numbers (maybe doesn't work with multi-page documents)
#		Other options you might want to try:  -V classoption:twocolumn
#	columns lua filter gives some capabilities for multicols. The syntax for style and where the columns are is written into the markdown on the lines beginning with :::.
	pandoc -s --from markdown+smart --pdf-engine=xelatex $(DATE) --lua-filter="./columns.lua" -V pagestyle=empty -V documentclass=$(LATEX_CLASS) -V classoption:landscape -V papersize=letter -V geometry:margin=.5in -o $@ $^

.PHONY: all book clean html pdf
