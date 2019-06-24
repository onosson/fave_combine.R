# fave_combine.R
R script for loading a folder of files as exported by FAVE-extract and combining normalized and non-normalized data into a single dataframe and spreadsheet; assumes that filenames are based on speaker name or ID code

1. After running FAVE-align and FAVE-extract (https://github.com/JoFrhwld/FAVE) save your formant data output files into a folder along with this script

2. Ensure that your non-normalized data files are in the format SPEAKER.txt and normalized data files are in the format SPEAKER_norm.txt

3. Run the script, which will produce a single file FAVE_data.csv containing all of the data output
