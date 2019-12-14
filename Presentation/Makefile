RUBBER=rubber
DOT=dot
EVINCE=evince

all: main.pdf

main.pdf: *.tex cnn.pdf pca.png ../Thesis/abbreviations.tex
	$(RUBBER) -d main.tex

show: main.pdf
	screen -dm $(EVINCE) main.pdf

present: main.pdf
	pdfpc main.pdf

%.pdf: ../Materalien/%.svg
	inkscape --file=$< --export-area-drawing --without-gui --export-pdf=$@

pca.png: ../Materialien/Presentation/pca.png
	convert ../Materalien/Presentation/pca.png -crop 100%x+300+0 pca.png
	convert pca.png -crop 100%x-000+0 pca.png

clean:
	rm -f *.toc
	rm -f *.aux
	rm -f *.log
	rm -f *.out
	rm -f *.bbl  
	rm -f *.blg  
	rm -f *-blx.bib  
	rm -f *.fdb_latexmk
	rm -f *.xml
	rm -f *.bcf
	rm -f *.png
	rm -f *.pdfpc
	rm -f *.md5
	rm -f *.dpth
	rm -f *.nav
	rm -f *.auxlock
	rm -f *.snm

clean_all: clean
	rm -f *.pdf
