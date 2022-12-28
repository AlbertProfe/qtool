#!/bin/bash

# Initialize an empty array
directories=()
filesXdir=()
files_dir=()
# Initialize a counter variable
counter=0
# Initialize a string variable
title=''
title_line=''
# Generate the log file name using the current date and time
log_file="$(date +"%Y%m%d-%H%M%S")-log-write-navLinks.txt"
# Couloring text
BLUE='\033[0;33m'
NC='\033[0m' # No Color
# Open the log file for writing
exec 3> "_logs/${log_file}"
exec 4> "dirTable.csv"
echo "COUNTER;DIR;FILE;TITLE" >&4

# Iterate over all directories and subdirectories in the parent directory
for dir in ../*/; do
  # Check if the directory is not named "images" or directories begin with "_*" and is not a hidden directory
  if [[ $dir != *"images"* ]] && [[ $dir != *"_"* ]] && [[ ${dir:2:1} != "." ]]; then
    directories+=("$dir")
    # Iterate over all files in the current directory
    for file in "$dir"*; do
      # Check if the file is a .qmd file
      if [[ $file == *".qmd" ]]; then
        let counter++
        files_dir+=($file)
        # Extract title from line 2 .qmd file
        title_line=$(awk 'NR==2 {print}' "${file}")
        #echo "$title_line"
        title=$(sed 's/.*"\(.*\)".*/\1/' <<< "$title_line")
        echo $counter";"$dir";"$file";"$title >&4
      fi
    done
  fi
done

# Print results
#echo -e "${BLUE}\nReal .qmd files in directory:${NC}"
#for ((i=0; i < ${#files_dir[@]}; i++)); do
#    echo -e "\t$((i+1)): ${files_dir[i]}"
#done

# Use nodejs and tty-table app with csv delimiter ";"
# need to install two packages:
# $ sudo apt-get install nodejs 
# $ npm install tty-table -g

echo -e "${BLUE}\nFrom local directory and .qmd files :${NC}"
cat dirTable.csv | tty-table --csv-delimiter ";"

# Close the file
exec 3>&-
exec 4>&-