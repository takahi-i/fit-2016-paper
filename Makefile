#!/usr/bin/env make

LATEX=platex
BIBTEX=bibtex
ETAGS=etags

SOURCES = \
	main.tex \
	content.tex \

BIBSOURCES = \
	reference.bib \
	reference-j.bib \

all: pdf

check:
	redpen --conf redpen-conf-ja.xml -f latex content.tex

pdf: dvi
	dvipdfm  main.dvi

dvi: main.dvi

%.dvi : %.tex
	$(LATEX) $* || rm -f $@
	$(BIBTEX) $*
	$(LATEX) $* || rm -f $@
	$(LATEX) $* || rm -f $@

main.dvi: $(SOURCE) $(BIBSOURCES)

TAGS: $(SOURCES)
	$(ETAGS) $^

clean:
	-rm -f *.log *.blg *~

realclean: clean
	-rm -f *.aux *.bbl *.dvi TAGS

