#
# This Makefile modified from original maintainer at:
# https://github.com/evangoer/pandoc-ebook-template
# Originally released under an MIT license
#
BUILD = built-files
BOOKNAME = Subworldbook1
# This BOOKNAME variable is the output file name, not the title
TITLE = title.txt
METADATA = metadata.xml
# Metadata is a part of the epub standard, even if it repeats stuff in the title file
CHAPTERS = full-draft-manuscript/two_preface.md full-draft-manuscript/1_Chapter.md full-draft-manuscript/2_Chapter.md full-draft-manuscript/3_Chapter.md full-draft-manuscript/4_Chapter.md full-draft-manuscript/5_Chapter.md full-draft-manuscript/6_Chapter.md full-draft-manuscript/7_Chapter.md full-draft-manuscript/8_Chapter.md ./LICENSE.txt
# I believe separate chapter files are just separated by a space --- see maintainer version to check
TOC = --toc --toc-depth=1
COVER_IMAGE = cover/pre-release-draft-front-cover-layout.png
# I think the cover pic works better if you use a .png or a .jpg
LATEX_CLASS = article
# While it seems like it would make sense to use 'book' for LATEX_CLASS,
# book sets up the file for book printing -- putting end-of-book pages on the reverse of the front-of-book pages.
# (There's probably a latex option to change that, but that is the default for book.)
# 'report' puts in annoying chapter numbers that I can't figure out how to get rid of with pandoc.
# This document is fairly simple, so 'article' works well --- though see notes in README.md on compiling.
CSS = css/clean-html.css
# This corresponds to the --css switch in the pandoc command
DATE = -M date="Version date - `date "+%B %e, %Y"`" 
# This line puts a version date into the compiled pandoc file using the -M metadata switch. The default setup puts in today's date

all: book

book: epub html pdf latex txt md 

clean:
	rm -r $(BUILD)

epub: $(BUILD)/epub/$(BOOKNAME).epub

html: $(BUILD)/html/$(BOOKNAME).html

pdf: $(BUILD)/pdf/$(BOOKNAME).pdf

latex: $(BUILD)/latex/$(BOOKNAME).tex

txt: $(BUILD)/txt/$(BOOKNAME).txt

md: $(BUILD)/markdown/$(BOOKNAME).md

$(BUILD)/epub/$(BOOKNAME).epub: $(TITLE) full-draft-manuscript/one_diagrams.md $(CHAPTERS)
	mkdir -p $(BUILD)/epub
# 	the .epub target includes one_diagrams.md so the diagrams get included in the .epub
# 	Note: if you look at the original source from the maintainer for this ebook compiler they have a -S in these lines. That switch is deprecated in modern pandoc. I added the --from markdown+smart instead to the pandoc compile lines.
# 	The --css references a simple css file used for formatting the epub. It is critically important because it centers the titles and separators among other things. It vastly improves the epub output. It is not included in the original maintainer's version.
	pandoc $(TOC) --css=css/epub.css --from markdown+smart --epub-metadata=$(METADATA) $(DATE) --epub-cover-image=$(COVER_IMAGE) -o $@ $^

$(BUILD)/html/$(BOOKNAME).html: $(TITLE) $(CHAPTERS)
	mkdir -p $(BUILD)/html
#	Below: Compiling html with the TOC enabled. The -s (standalone) flag is required to get the TOC to work.
#	The --self-contained tells pandoc to include the css in the html file, rather than just referencing it.
	pandoc -s $(TOC) --css=$(CSS) --self-contained $(DATE) --from markdown+smart --to=html5 -o $@ $^

$(BUILD)/pdf/$(BOOKNAME).pdf: $(TITLE) $(CHAPTERS)
	mkdir $(BUILD)/pdf
#	Below with some latex options (-V) added.
	pandoc $(TOC) -s --from markdown+smart --pdf-engine=xelatex $(DATE) -V documentclass=$(LATEX_CLASS) -V classoption:twocolumn -V classoption:landscape -V papersize=letter -o $@ $^

$(BUILD)/latex/$(BOOKNAME).tex: $(TITLE) $(CHAPTERS)
	mkdir $(BUILD)/latex
#	I use this target for prepping for paper version of the book 
#	(so, scrbook latex class is used here and page it set to 5.5x8.25)
#	No TOC for book printing file
#	Below with some latex options (-V) added.
	pandoc -s --from markdown+smart --top-level-division=chapter $(DATE) -V documentclass=scrbook -V geometry:paperwidth=5.5in -V geometry:paperheight=8.25in -o $@ $^

$(BUILD)/txt/$(BOOKNAME).txt: $(TITLE) $(CHAPTERS)
	mkdir -p $(BUILD)/txt
#	No TOC for txt file
	pandoc -s --from markdown+smart $(DATE) -o $@ $^

$(BUILD)/markdown/$(BOOKNAME).md: $(TITLE) $(CHAPTERS)
	mkdir -p $(BUILD)/markdown
# 	markdown target just turns the chapters into a single, cleaned up md file.
	pandoc -s $(TOC) --from markdown+smart $(DATE) --to=markdown -o $@ $^


.PHONY: all book clean epub html pdf latex txt md
