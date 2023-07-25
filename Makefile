.PHONY: view clean

# Get the current version
current_version := $(shell git describe --tags --abbrev=0)

# Filename with the current date
output_filename := EnergySavings_HomeWork_$(current_version).pdf

# Define variables
md_files 		:= $(wildcard *.md)
tex_files 		:= $(wildcard latex/*.tex)
doc_file 		:= notes/draft_$(shell date +'%Y-%m-%d').docx
opts 			:= 	-H latex/preamble.tex -B latex/before.tex \
							--embed-resources -N \
							--template=latex/template.tex

render_pdf := pandoc --from=markdown+yaml_metadata_block -C \
				-H latex/preamble.tex -B latex/before.tex \
				--embed-resources -N \
				--template=latex/template.tex

# Define targets
all: $(output_filename)

# Define references
refs.bib : $(HOME)/iCloud/Readings/Energy/_nrg.bib
	cp $< $@

# Create main file in latex
main.tex : config.yml $(md_files) $(tex_files) refs.bib 
	$(render_pdf) $< $(md_files) -o $@

# Convert to pdf
$(output_filename) : main.tex
	@xelatex $< && cp main.pdf $@

# Convert to docx
docx : main.tex
	@pandoc $< --from latex --to docx -o $(doc_file)
	@open $(doc_file)

view:
	open -a Skim $(output_filename)

clean:
	rm -f main.* $(output_filename)

