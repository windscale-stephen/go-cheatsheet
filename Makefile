CONVERT=gm convert

all: go-cheatsheet.pdf go-cheatsheet-a4.pdf go-cheatsheet-0.png go-cheatsheet-thumb-0.png

clean:
	rm -f go-cheatsheet.pdf go-cheatsheet-a4.tex go-cheatsheet-a4.pdf \
	      go-cheatsheet-0.png go-cheatsheet-1.png \
	      go-cheatsheet-thumb-0.png go-cheatsheet-thumb-1.png \
	      go-cheatsheet.out go-cheatsheet-a4.out

go-cheatsheet.pdf: go-cheatsheet.tex
	pdflatex go-cheatsheet.tex
	rm -f go-cheatsheet.aux go-cheatsheet.log go-cheatsheet.out

# OK, this is kind of a hack to add 'a4paper' to the header
go-cheatsheet-a4.tex: go-cheatsheet.tex
	cat go-cheatsheet.tex | sed -e 's/\\usepackage\[landscape\]/\\usepackage\[a4paper,landscape\]/' > go-cheatsheet-a4.tex

go-cheatsheet-a4.pdf: go-cheatsheet-a4.tex
	pdflatex go-cheatsheet-a4.tex
	rm -f go-cheatsheet-a4.tex go-cheatsheet-a4.aux go-cheatsheet-a4.log go-cheatsheet-a4.out

go-cheatsheet-0.png: go-cheatsheet.pdf
	$(CONVERT) -density 100x100 +adjoin go-cheatsheet.pdf go-cheatsheet-%d.png

go-cheatsheet-thumb-0.png: go-cheatsheet.pdf
	$(CONVERT) -density 32x32 +adjoin go-cheatsheet.pdf go-cheatsheet-thumb-%d.png
