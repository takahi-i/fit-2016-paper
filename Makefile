#!/usr/bin/env make

LATEX=platex
BIBTEX=bibtex
ETAGS=etags

SOURCES = \
	main.tex \

# BIBSOURCES = \
# 	reference.bib \

all: pdf

check:
	pandoc content.tex -s -t markdown -o content.md
	redpen --conf redpen-conf.xml -f markdown content.md

pdf: dvi
	dvipdfm  main.dvi

dvi: main.dvi

%.dvi : %.tex
	$(LATEX) $* || rm -f $@
	$(BIBTEX) $*
	$(LATEX) $* || rm -f $@
	$(LATEX) $* || rm -f $@

main.dvi: $(SOURCE) 

TAGS: $(SOURCES)
	$(ETAGS) $^

clean:
	-rm -f *.log *.blg *~

realclean: clean
	-rm -f *.aux *.bbl *.dvi TAGS

