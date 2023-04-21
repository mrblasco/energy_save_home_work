report := final.pdf
md_files := $(wildcard *.md)
tex_files := $(wildcard latex/*.tex)

all: refs.bib $(report)

refs.bib : $(HOME)/iCloud/Readings/Energy/_nrg.bib
	cp $< $@

opts:= -H latex/preamble.tex -B latex/before.tex --embed-resources -N

main.tex :$(md_files)
	@pandoc $+ -C -o $@ $(opts)

%.pdf : %.tex $(tex_files)
	xelatex $<

draft.docx : main.tex
	@pandoc $< --from latex -o $@

$(report): img/cover_blue_v1bis.pdf main.pdf img/final_page.pdf
	@pdfunite $+ $@

view:
	open -a Skim $(report)
