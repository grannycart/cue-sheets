#
# This Makefile modified from original maintainer at:
# https://github.com/evangoer/pandoc-ebook-template
# Originally released under an MIT license
#
# This is the built files directory, all output files will be created in here:
BUILD = built-files
# This FILENAME variable is the output file name:
FILENAME = cue-sheet-1-formatted
# This is the name of the (input) markdown version of your cue sheet:
CUE_SHEET = cue-sheet-1.md
LATEX_CLASS = article
# This corresponds to the --css switch in the pandoc command:
CSS = css/clean-html.css
# This line puts a version date into the compiled pandoc file using the -M metadata switch. The default setup puts in today's date:
DATE = -M date="Version date - `date "+%B %e, %Y"`" 

all: book

book: html pdf

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
	pandoc -s --from markdown+smart --pdf-engine=xelatex $(DATE) -V documentclass=$(LATEX_CLASS) -V classoption:twocolumn -V classoption:landscape -V papersize=letter -o $@ $^

.PHONY: all book clean html pdf
