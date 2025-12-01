
MY_TEX_SRC=abstract.tex bsc-thesis.tex zusammenfassung.tex
MAIN_FILE=bsc-thesis
MY_BIB_SRC=references.bib

all: bsc-thesis.pdf


bsc-thesis.pdf: $(MY_TEX_SRC) 
	pdflatex $(MAIN_FILE)
	bibtex $(MAIN_FILE)	
	pdflatex $(MAIN_FILE)
	pdflatex $(MAIN_FILE)

