RUBBER=rubber
DOT=dot
EVINCE=evince

all: main_mrm.pdf

main_mrm.pdf: *.tex pc0Clutter.png pc0NotMerged.png pc1OverClustering.png pc1Sign.png typeSparse.png bibliography.bib ../Material/* cnn.pdf EpipolarGeometry.pdf coord.png disparity.png
	$(RUBBER) -d main_mrm.tex

spelling: *.tex
	aspell -t -l en -c intro.tex
	aspell -t -l en -c theorie.tex
	aspell -t -l en -c objectdetection.tex
	aspell -t -l en -c evaluation.tex
	aspell -t -l en -c conclusion.tex

show: main_mrm.pdf
	screen -dm $(EVINCE) main_mrm.pdf

pc0Clutter.png: ../Material/pc0Clutter.png
	convert ../Material/pc0Clutter.png -fuzz 0% -transparent black pc0Clutter.png

pc0NotMerged.png: ../Material/pc0NotMerged.png
	convert ../Material/pc0NotMerged.png -fuzz 0% -transparent black pc0NotMerged.png

pc1OverClustering.png: ../Material/pc1OverClustering.png
	convert ../Material/pc1OverClustering.png -fuzz 0% -transparent black pc1OverClustering.png

pc1Sign.png: ../Material/pc1Sign.png
	convert ../Material/pc1Sign.png -fuzz 0% -transparent black pc1Sign.png

typeSparse.png: ../Material/typeSparse.png
	convert ../Material/typeSparse.png -fuzz 0% -transparent black typeSparse.png

%.pdf: ../Material/%.svg
	inkscape --file=$< --export-area-drawing --without-gui --export-pdf=$@

coord.png: ../Material/coord.scad
	openscad -o coord.png --imgsize=1920,1080 --projection=ortho --colorscheme=Nature --camera=-0.625456,-0.307041,1.632,70,0,135,26 ../Material/coord.scad
	convert coord.png -fuzz 5% -transparent white coord.png

disparity.png: ../Material/disparity.png
	python3 ../Util/Evaluation/grey2color.py ../Material/disparity.png disparity.png
	convert disparity.png -crop 100%x+70+0 disparity.png

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

clean_all: clean
	rm -f *.pdf
