#!/bin/bash

# Initialize an empty array
files=()
domains=()
directories=()
filesXdir=()
filesXdomain=()
files_dir=()
# Initialize a counter variable
counter=0
counter_qmd=0
counter_dir=0
counter_files_qmd=0
counter_filesXdir=0
counter_filesXdomain=0
counter_fxd_last=0
# Generate the log file name using the current date and time
log_file="$(date +"%Y%m%d-%H%M%S")-log-write-navLinks.txt"
# Initialize a string variable
path_qmd=''
domain_qmd=''
# Initialize a lineNumber_navLinks_is variable
lineNumber_navLinks_is=-1
# Couloring text
BLUE='\033[0;33m'
NC='\033[0m' # No Color
# Open the log file for writing
exec 3> "_logs/${log_file}"

echo "*********** check nav: .qmds vs ,yml  *************" >&3

# Read the input code line by line
while IFS= read -r line; do
    # If the line ends with ".qmd", add it to the array
    if [[ $line == *".qmd" ]]; then
        let counter_qmd++
       
        # Extract path and domain from the lines ends with ".qmd"
        path_qmd="$(echo "$line" | tr -d ':' | sed 's/- //g' | tr -d ' ' | sed 's/file//g')"
        domain_qmd=$(cut -d '/' -f 1 <<< "$path_qmd");
        # Add .qmd path to files array
        files+=("$path_qmd")
        # Add domain to domains array if it is new
        if [[ ! "${domains[*]}" =~ "$domain_qmd" ]]; then
          domains+=("$domain_qmd")
          
          let counter_filesXdomain=1
        else
          let counter_filesXdomain++
        fi
        counter_fxd_last=(${#domains[@]}-1)
        let filesXdomain[$counter_fxd_last]=$counter_filesXdomain
        # Write a message to the log file indicating that .qmd path has been extracted
        echo "$(date +"%Y-%m-%d %H:%M:%S") - extracting from _quarto.yml' $counter_qmd: $path_qmd" >&3
        #echo "$(date +"%Y-%m-%d %H:%M:%S") total .qmds and domains: $counter_qmd - ${#domains[@]}"
    fi
done < "../_quarto.yml"

echo -e "${BLUE}From _quarto.yml:${NC}"
echo "Number of domains: $((${#domains[@]}-1))"
echo "Number of .qmd files: $counter_qmd"
echo "Domain list:"
for ((i=0; i<${#domains[@]}; i++)); do
    echo -e "\tDomain ${i}: ${domains[i]} \t${filesXdomain[i]}"
done

# Iterate over all directories and subdirectories in the parent directory
for dir in ../*/; do
  # Check if the directory is not named "images" or directories begin with "_*" and is not a hidden directory
  if [[ $dir != *"images"* ]] && [[ $dir != *"_"* ]] && [[ ${dir:2:1} != "." ]]; then
    ((counter_dir++))
    directories+=("$dir")
    counter_filesXdir=0
    # Iterate over all files in the current directory
    for file in "$dir"*; do
      # Check if the file is a .qmd file
      if [[ $file == *".qmd" ]]; then
        ((counter_files_qmd++))
        ((counter_filesXdir++))
        files_dir+=($file)
      fi
    done
  filesXdir+=($counter_filesXdir)
  fi
done

# Print results
echo -e "${BLUE}\nFrom local project dir:${NC}"
echo "Number of directories: $counter_dir"
echo "Number of .qmd files: $counter_files_qmd"
echo "Directories list:"
for ((i=0; i < ${#directories[@]}; i++)); do
    echo -e "\tDirerctory $((i+1)): ${directories[i]} \t${filesXdir[i]}"
done

# Close the file
exec 3>&-



