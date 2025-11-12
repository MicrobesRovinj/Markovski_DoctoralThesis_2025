## Sediment microbial communities in a *Cymodocea nodosa* seagrass meadow

This is the repository for the doctoral thesis "Sediment microbial communities in a *Cymodocea nodosa* seagrass meadow" written by Marsej Markovski. This doctoral thesis was completed at the Ruđer Bošković Institute, Centre for Marine Research, Laboratory for Marine Microbial Ecology and Laboratory for Benthic Ecology, Rovinj, under the supervision of Marino Korlević, PhD, as part of the Interdisciplinary Doctoral Study in Oceanology at the University of Zagreb Faculty of Science, Department of Geology. This README file contains an overview of the repository structure, information about software dependencies, and instructions for compiling the PDF of the doctoral thesis.

### Overview

	project
	|- README.md                           # the top level description of content (this document)
	|- LICENSE.md                          # the license for this project
	|
	|- _bookdown.yml                       # configuration file for the R package bookdown
	|- _output.yml                         # configuration and customisation file for output formats 
	|- index.Rmd                           # the R Markdown index file for the R package bookdown (the only R Markdown file to contain a YAML header)
	|
	|- 01-introduction.Rmd                 # the R Markdown file for the chapter "Introduction"
	|- 02-objectives-and-hypotheses.Rmd    # the R Markdown file for the chapter "Objectives and hypotheses"
	|- 03-scientific-articles.Rmd          # the R Markdown file for the chapter "Scientific articles"
	|- 04-discussion.Rmd                   # the R Markdown file for the chapter "Discussion"
	|- 05-conclusions.Rmd                  # the R Markdown file for the chapter "Conclusions"
	|- 06-bibliography.Rmd                 # the R Markdown file for the chapter "Bibliography"
	|- 07-biography.Rmd                    # the R Markdown file for the chapter "Biography"
	|- 08-appendices.Rmd                   # the R Markdown file for the chapter "Appendices"
	|
	|- _book/                              # the output document and intermediate files generated during the compilation process
	| |- _main.tex                         # the TEX file of the doctoral thesis (the output document)
	| +- _main.pdf                         # the PDF of the doctoral thesis (the output document)
	|
	|- articles/                           # scientific articles and supplementary material for the output document
	|
	|- code/                               # any programmatic code used in the project
	| +- functions/                        # custom functions
	|
	|- figures/                            # figures for the output document
	| +- logo/                             # images of the university logo
	|
	|- filters/                            # Lua filters to manipulate the Pandoc abstract syntax tree (AST)
	| |- translate_citations_to_hr.lua     # filter to translate citations from English to Croatian in the defined section
	| +- abbreviate_given_name.lua         # filter to abbreviate certain Croatian given names to two symbols
	|
	|- latex/                              # files required by LaTeX to properly compile the PDF
	| |- preamble.tex                      # LaTeX file containing information on packages used and customisations applied
	| +- before_body.tex                   # LaTeX file defining additional customisations applied, e.g. the formatting for title pages
	|
	|- bibliography/                       # files necessary for referencing
	| |- references.bib                    # BibLaTeX formatted references
	| |- r-packages.bib                    # BibLaTeX formatted references for cited R packages
	| +- citation_style.csl                # CSL file used to format references
	|
	|- .gitignore                          # .gitignore file for this repository
	|- .Rprofile                           # .Rprofile file containing information on which R libraries and custom functions to load, etc.
	|
	+- project_file.Rproj                  # RStudio IDE project file for this repository

### How to regenerate this repository

#### Dependencies
* GNU Bash (v. 5.2.21(1)), should be located in user's PATH
* R (v. 4.5.1), should be located in user's PATH
* RStudio IDE (v. 2025.05.0+496), if RStudio IDE is used to compile the PDF (see below)
* R packages:
  * `stats (v. 4.5.1)`
  * `knitr (v. 1.50)`
  * `bookdown (v. 0.45)`
  * `tidyverse (v. 2.0.0)`

#### Compile the PDF
The PDF of the doctoral thesis can be compiled on a Linux computer by running the following commands:
```
git clone https://github.com/MicrobesRovinj/Markovski_DoctoralThesis_2025.git
cd Markovski_DoctoralThesis_2025/
R -e "render_book(input = 'index.Rmd')"
```
Alternatively, the last command can be replaced by opening the `project_file.Rproj` in RStudio IDE and clicking *Build Book* in the Build Pane.

