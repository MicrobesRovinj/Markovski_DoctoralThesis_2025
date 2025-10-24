#################################################################################################################
# write_software_version.R
#
# Script to add software version to the README.md file in the project root directory.
#
#################################################################################################################

# Read the content of the input md file
readme <- read_lines(file = "README.md")

# Find indices of lines requiring update
bash_index <- grep(pattern = "^\\* GNU Bash \\(v\\.", x = readme)
r_index <- grep(pattern = "^\\* R \\(v\\.", x = readme)
rstudio_index <- grep(pattern = "\\* RStudio IDE \\(v\\.", x = readme)
indices <- c(bash = bash_index, r = r_index, rstudio = rstudio_index)

# Find software version
bash_version <- system("bash --version", intern = TRUE)[1]
r_version <- system("R --version", intern = TRUE)[1]
rstudio_version <- system("rstudio --version", intern = TRUE)

# Extract software version
versions <- c(bash_version, r_version, rstudio_version) %>%
  str_extract(pattern = "[0-9.\\+()]+")
names(versions) <- c("bash", "r", "rstudio")

# Add software version to md file
readme[indices["bash"][[1]]] <- paste0("* GNU Bash (v. ", versions["bash"][[1]], ")", ", should be located in user's PATH")
readme[indices["r"][[1]]] <- paste0("* R (v. ", versions["r"][[1]], ")", ", should be located in user's PATH")
readme[indices["rstudio"][[1]]] <- paste0("* RStudio IDE (v. ", versions["rstudio"][[1]], ")", ", if RStudio IDE is used to compile the PDF (see below)")

# Write modified md file
write_lines(x = readme, file = "README.md")
