#
# GNU Make Makefile
#
MAINDOC = $(shell basename $$(pwd))
LTXARGS = -pdfdvi -use-make -bibtex -quiet
IMGDIR = ./imgs
IMGS = $(wildcard $(IMGDIR)/*.svg)
IMGS += $(wildcard $(IMGDIR)/*.png)
IMGEPS = $(addsuffix .eps, $(basename $(IMGS)))

.PHONY: $(MAINDOC).pdf all clean

all: $(MAINDOC).pdf

%.eps: %.svg
	inkscape -z -T -E $@ $<

%.eps: %.png
	convert $< eps3:$@

$(MAINDOC).pdf: $(IMGEPS) $(MAINDOC).tex
	TEXINPUTS="./styles//:${TEXINPUTS}" BSTINPUTS="./styles//:${BSTINPUTS}" latexmk $(LTXARGS) $(MAINDOC).tex

clean:
	latexmk -bibtex -C
	rm -f $(IMGEPS) *~
