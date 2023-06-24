# Define variables
report := final.pdf
md_files := $(wildcard *.md)
tex_files := $(wildcard latex/*.tex)
cover := cover_page.pdf
doc_file := draft_$(shell date +'%Y-%m-%d').docx
opts := -H latex/preamble.tex -B latex/before.tex --embed-resources -N


# Define targets
all: refs.bib $(report)

refs.bib : $(HOME)/iCloud/Readings/Energy/_nrg.bib
	cp $< $@

main.tex : config.yml $(md_files)
	@pandoc --from=markdown+yaml_metadata_block $+ -C -o $@ $(opts)

%.pdf : %.tex $(tex_files)
	xelatex $<

docx : main.tex
	@pandoc $< --from latex --to docx -o $(doc_file)

<<<<<<< HEAD
$(report): $(cover) main.pdf final_page.pdf
=======
$(report): cover_blue_v1bis.pdf main.pdf final_page.pdf
>>>>>>> 55a12151572c57028b743991e7b2b476dd43edf6
	@pdfunite $+ $@

view:
	open -a Skim $(report)
