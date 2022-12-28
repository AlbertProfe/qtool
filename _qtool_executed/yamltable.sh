#!/bin/bash

# Initialize an empty array
files=()
# Initialize a counter variable
counter=0
op_counter=0
# Generate the log file name using the current date and time
log_file="$(date +"%Y%m%d-%H%M%S")-log-write-navLinks.txt"
# Initialize a string variable
path_qmd=''
domain_qmd=''
title=''
title_line=''
section_line=''
section=''
# Initialize a lineNumber_navLinks_is variable
lineNumber_navLinks_is=-1
# Couloring text
BLUE='\033[0;33m'
NC='\033[0m' # No Color

# Open the log file for writing
exec 3> "_logs/${log_file}"
exec 4> "yamlTable.csv"
echo "COUNTER;DOMAIN;SECTION;PATH;TITLE" >&4

echo "***************** upadate yamltable ****************" >&3

# Read the input code line by line
while IFS= read -r line; do
  if [[ $line == *"section"* ]]
  then
    # Save line to variable
    section_line="$line"
    #echo "$section_line"
    section=$(sed 's/.*"\(.*\)".*/\1/' <<< "$section_line")
    #echo "$section"
  else
      # If the line ends with ".qmd", add it to the array
      if [[ $line == *".qmd" ]]; then
        # Extract path and domain from the lines ends with ".qmd"
        path_qmd="$(echo "$line" | tr -d ':' | sed 's/- //g' | tr -d ' ' | sed 's/file//g')"
        domain_qmd=$(cut -d '/' -f 1 <<< "$path_qmd");
        files+=("$path_qmd")
        let counter++
        # Extract title from line 2 .qmd file
        title_line=$(awk 'NR==2 {print}' "../${path_qmd}")
        #echo "$title_line"
        title=$(sed 's/.*"\(.*\)".*/\1/' <<< "$title_line")
        #echo "$title"
        # Write a message to the log file indicating that .qmd path has been extracted
        echo "$(date +"%Y-%m-%d %H:%M:%S") - extracting from _quarto.yml' $counter: $path_qmd" >&3
        #echo 'extracting from _quarto.yml' $counter: $path_qmd
        echo $counter";"$domain_qmd";"$section";"$path_qmd";"$title >&4
      fi
  fi
done < "../_quarto.yml"

# Use nodejs and tty-table app with csv delimiter ";"
# need to install two packages:
# $ sudo apt-get install nodejs 
# $ npm install tty-table -g

echo -e "${BLUE}\nFrom .yml and .qmd Title :${NC}"
cat yamlTable.csv | tty-table --csv-delimiter ";"

# Close the file
exec 3>&-
exec 4>&-
