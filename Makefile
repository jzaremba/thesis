all:
	docker run -it --rm -e "USER=$(shell id -un)" -e "USER_ID=$(shell id -u)" -e "GROUP_ID=$(shell id -g)" -v $(shell pwd):/opt/workdir jzaremba/tex pdflatex main
	docker run -it --rm -e "USER=$(shell id -un)" -e "USER_ID=$(shell id -u)" -e "GROUP_ID=$(shell id -g)" -v $(shell pwd):/opt/workdir jzaremba/tex bibtex main
	docker run -it --rm -e "USER=$(shell id -un)" -e "USER_ID=$(shell id -u)" -e "GROUP_ID=$(shell id -g)" -v $(shell pwd):/opt/workdir jzaremba/tex pdflatex main
	docker run -it --rm -e "USER=$(shell id -un)" -e "USER_ID=$(shell id -u)" -e "GROUP_ID=$(shell id -g)" -v $(shell pwd):/opt/workdir jzaremba/tex pdflatex main

fast:
	docker run -it --rm -e "USER=$(shell id -un)" -e "USER_ID=$(shell id -u)" -e "GROUP_ID=$(shell id -g)" -v $(shell pwd):/opt/workdir jzaremba/tex pdflatex main

clean:
	rm main.aux main.log main.out main.blg main.bbl main.toc main.lof main.lot 2>/dev/null

.PHONY: all fast clean
