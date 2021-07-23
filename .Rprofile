# Machine-wide R startup options

# IMPORTANT: Make sure that this file only changes aesthetics and other settings that will not affect the actual evaluation of any code in R

# create a new hidden environment so that custom functions are not deleted when the workspace is cleared
.env = new.env()

# set the default CRAN mirror
local({
  r = getOption("repos")             
  r["CRAN"] = "https://cran.rstudio.com/"
  options(repos = r)
})

# enable colorized output
try(suppressMessages(library(colorout)), silent = TRUE)
try(setOutputColors(normal = 39, const = 124, true = 34, verbose = FALSE), silent = TRUE)

# set the prompt symbol so it's clear when we're using R
options(prompt = "R> ")

# set the default number of digits to 4
# options(digits = 4)

# hide stars for statistical significance
options(show.signif.stars = FALSE)

# create a function that changes the width of the R window to the current terminal width
.env$setwidth <- function(new_width = Sys.getenv("COLUMNS")){
	options(width = as.integer(system("tput cols", intern = TRUE)) - 1)
}

# create a function to clear the terminal window (using terminal's clear command so you don't have to type Ctrl + L)
.env$clear <- function(){
	system("clear")
}

# create a function to clear the workspace (remove all data, variables, custom functions, etc.)
.env$clear_workspace <- function(){
	rm(list = ls())
}

# set width of R window to current terminal width
if(interactive()){
	options(width = as.integer(system("tput cols", intern = TRUE)) - 1)
}

# attach .env (the hidden environment), allowing the use of custom functions by their names
attach(.env)

# runs this function at startup -  prints a welcome message
.First <- function(){
	message("Started at ", Sys.time(), "\n")
}

# runs this function on quit - prints a goodbye message
.Last <- function(){
	message("\nLeft at ", Sys.time(), "\n")
}
