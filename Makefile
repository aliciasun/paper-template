.DEFAULT_GOAL := help
SHELL = /bin/sh

MAIN = main

help:
	@echo "make help"
	@echo "    main: compile main.pdf"
	@echo "    poster: compile poster.pdf"
	@echo "    clean: clean LaTeX build files"
	@echo
	@echo "    *Note*: uses \`latexmk' for compilation management. Please install latexmk"
	@echo "            if you do not have it already."


.PHONY: main
main:
	latexmk -pdf $@

.PHONY: poster
poster: logo
	latexmk -pdf $@

.PHONY: clean
clean: _clean-main _clean-poster

.PHONY: _clean-main
_clean-main:
	latexmk -quiet -C main

.PHONY: _clean-poster
_clean-poster:
	latexmk -quiet -C poster

.PHONY: logo
logo: _dirs images/logos/MIT-logo-red-gray.eps

.PHONY: _dirs
_dirs:
	@test -d images/logos || mkdir -p images/logos

images/logos/MIT-logo-red-gray.eps:
	@echo "Use your browser to download the zip file into ./images/logos (MIT certificate required):"
	@echo "   -> https://web.mit.edu/graphicidentity/download/logo-sets/MIT-logos-print.zip"
	@read -p "Press any character to continue when you are done..." -n 1 -s && printf '\n'
	@test -f images/logos/MIT-logos-print.zip || { echo "You failed to download the zip file" && exit 1; }
	unzip -q images/logos/MIT-logos-print.zip -d images/logos && mv images/logos/MIT-logos-print/*.eps images/logos/
	-rm -r images/logos/MIT-logos-print
	-rm -r images/logos/__MACOSX
	-rm images/logos/MIT-logos-print.zip

.PHONY: examples
examples: main poster
	test -d examples || mkdir examples
	cp main.pdf poster.pdf examples
