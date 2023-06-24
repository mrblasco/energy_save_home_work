# Define variables
report_file 	:= main.pdf
md_files 		:= $(wildcard *.md)
tex_files 		:= $(wildcard latex/*.tex)
doc_file 		:= draft_$(shell date +'%Y-%m-%d').docx
opts := -H latex/preamble.tex -B latex/before.tex --embed-resources -N --template=latex/template.tex

# Define targets
all: $(report_file)

refs.bib : $(HOME)/iCloud/Readings/Energy/_nrg.bib
	cp $< $@

main.tex : config.yml $(md_files) $(tex_files) refs.bib 
	@pandoc --from=markdown+yaml_metadata_block $< $(md_files) -C -o $@ $(opts)

%.pdf : %.tex
	xelatex $<

docx : main.tex
	@pandoc $< --from latex --to docx -o $(doc_file)

view:
	open -a Skim $(report_file)
