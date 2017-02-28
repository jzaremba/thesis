all:
	docker run -v $(shell pwd):/build -w /build harshjv/texlive-2015 pdflatex main
	docker run -v $(shell pwd):/build -w /build harshjv/texlive-2015 bibtex main
	docker run -v $(shell pwd):/build -w /build harshjv/texlive-2015 pdflatex main
	docker run -v $(shell pwd):/build -w /build harshjv/texlive-2015 pdflatex main

fast:
	docker run -v $(pwd):/build -w /build harshjv/texlive-2015 pdflatex main

clean:
	rm main.aux main.log main.out main.blg main.bbl main.toc main.lof main.lot

.PHONY: all fast clean
