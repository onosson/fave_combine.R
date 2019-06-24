# load required packages
library(tidyverse)
library(stringr)

# make a list of all FAVE and FAVE_norm output files in the folder
FAVE_files <- list.files(pattern = "\\.txt$") # all ".txt" files
FAVE_files <- FAVE_files[-grep("_norm", FAVE_files)] # remove files with "_norm" from first list
FAVE_norm_files <- list.files(pattern = "\\_norm.txt$") # all "_norm.txt" files

# check that there are both FAVE and FAVE_norm files in equal numbers
if (length(FAVE_files)!=length(FAVE_norm_files)) {
  print("WARNING: some FAVE data files appear to be missing!")} else {
  print("All FAVE data files appear to be present")}

# erase any previous FAVE dataframes
FAVE_data <- NULL

# loop through and load each FAVE output file into dataframes
for (d in 1:length(FAVE_files)) {
  
  # create speaker ID from filename
  speaker_id <- FAVE_files[d]
  
  # combine speaker ID with FAVE data from current file
  speaker_data <- cbind(speaker_id, read_tsv(FAVE_files[d]))
    
  # load norm_data from current file; ignores 1st line which contains redundant info, and 2nd line which is blank
  speaker_norm_data <- read_tsv(FAVE_norm_files[d], skip = 2)
  
  # eliminate duplicated norm_data columns
  speaker_norm_data <- subset(speaker_norm_data, select=-c(vowel,stress,word,t,beg,end,dur,style,glide,nFormants))
  
  # join norm_data columns to non-normalized dataframe
  this_data <- cbind(speaker_data, speaker_norm_data)
  
  # add current file FAVE data to FAVE dataframe
  FAVE_data <- rbind (FAVE_data, this_data)
}

# remove all @ and % characters from column names, e.g. F1@20% -> F1.20
# this step is optional and merely makes working with FAVE column names easier
names(FAVE_data) <- str_replace_all(names(FAVE_data), c("@" = "." , "%" = "" ))

# backup data in Excel-friendly .csv spreadsheet
write_excel_csv(FAVE_data,"FAVE_data.csv")
