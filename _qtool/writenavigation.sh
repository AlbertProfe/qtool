#!/bin/bash

# Initialize an empty array
files=()
titles=()
# Initialize a counter variable
counter=0
op_counter=0
total_files=0
second_last=0
# Generate the log file name using the current date and time
log_file="$(date +"%Y%m%d-%H%M%S")-log-write-navLinks.txt"
# Initialize a string variable
path_qmd=''
title=''
title_line=''

# Open the log file for writing
exec 3> "_logs/${log_file}"

echo "***************** Extracting **********************" >&3

# Read the input code line by line
while IFS= read -r line; do
  # If the line ends with ".qmd", add it to the array
  if [[ $line == *".qmd" ]]; then
    ((counter++))
    # Extract path qmd file and add to array files
    path_qmd="$(echo "$line" | tr -d ':' | sed 's/- //g' | tr -d ' ' | sed 's/file//g')"
    files+=("$path_qmd")
    # Extract title from qmd file and add to array titles
    title_line=$(awk 'NR==2 {print}' "../${path_qmd}")
    title=$(sed 's/.*"\(.*\)".*/\1/' <<< "$title_line")
    titles+=("$title")
    # Write a message to the log file indicating that .qmd path has been extracted
    echo "$(date +"%Y-%m-%d %H:%M:%S") - extracting from _quarto.yml and .qmd file' $counter: $path_qmd > $title" >&3
    echo " _quarto.yml/.qmd file' $counter: $path_qmd > $title" >&3
  fi
done < "../_quarto.yml"

echo "***************** Writing  ************************" >&3

total_files=${#files[@]}
second_last=$((${#files[@]}-1))
#echo 'total_files:' $total_files ' - ' $second_last
# Loop through the array of .qmd files
for ((i=0; i<${#files[@]}; i++)); do
  # Open the .qmd file
  file="${files[i]}"
  ((op_counter++))
  echo "$(date +"%Y-%m-%d %H:%M:%S") - Operation #($op_counter): **${file}**" >&3
  echo 'operartion:' $op_counter' > writing to: '$file
  
  # Delete qmd rows navLinks
  # Search for the line containing the string "<!--- navLinks -->"
  lineNumber_navLinks_is=$(grep -c "<!--- navLinks -->" "../${file}")
  # If the line was found, delete all lines after it
  if [ "$lineNumber_navLinks_is" -gt 0 ]; then
    # Store the line number of the first match
    lineNumber_navLinks=$(grep -n "<!--- navLinks -->" "../${file}" | awk -F: '{print $1}')
    # Delete all lines after the line number
    ((lineNumber_navLinks++))
    echo "lineNumber_navLinks:" $lineNumber_navLinks
    sed -i "$lineNumber_navLinks,\$d" "../${file}"
  else
    echo "<!--- navLinks -->" >> "../${file}"
  fi

  # Write the columns callout init in anycase to .qmd file
  echo "<br><br>" >> "../${file}"
  echo "<div class="row">" >> "../${file}"
  echo "<br>" >> "../${file}"
  echo "<div class='column left previous'>" >> "../${file}"
  echo "<br>" >> "../${file}"

  #previous link
  #just for home/index
  if [ "$i" -eq 0 ]; then
    echo "[{{< fa solid arrow-left >}} "${titles[$second_last]}"](/"${files[$second_last]}")" >> "../${file}"
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Added to previous article ["${titles[$second_last]}"](/"${files[$second_last]}")" >&3
  else
    echo "$(date +"%Y-%m-%d %H:%M:%S") - No Articles "${titles[$second_last]}"](/"${files[$second_last]}") found" >&3
  fi
  #previous link
  #for all articles
  if [ "$i" -gt 0 ] && [ "$i" -lt "$second_last" ]; then
    echo "[{{< fa solid arrow-left >}} "${titles[i-1]}"](/"${files[i-1]}")" >> "../${file}"
    echo "$(date +"%Y-%m-%d %H:%M:%S") - #$: Added article "${titles[i-1]}" to previous file "${files[i-1]}" to "${file} >&3
  else
    echo "$(date +"%Y-%m-%d %H:%M:%S") - No previous file found for "${file} >&3
  fi
  #previous link
  #just for last page, cards-listing
  if [ "$i" -eq "$second_last" ]; then
    echo "[{{< fa solid arrow-left >}} "${titles[i-1]}"](/"${files[i-1]}")" >> "../${file}"
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Added to previous article "${titles[i-1]}"](/"${files[i-1]}")" >&3
  else
    echo "$(date +"%Y-%m-%d %H:%M:%S") - No Articles "${titles[i-1]}"](/"${files[i-1]}") found" >&3
  fi

  #elevator arrow to top file
  echo "<br>" >> "../${file}"
  echo "</div>" >> "../${file}"
  echo "<br>" >> "../${file}"
  echo "<div class='column center'>" >> "../${file}"
  echo "<br>" >> "../${file}"
  echo "[{{< fa solid arrow-up >}} top](#top)"  >> "../${file}" 
  echo "<br>" >> "../${file}"
  echo "</div>" >> "../${file}"
  echo "<br>" >> "../${file}"
  echo "<div class='column right next'>"  >> "../${file}"
  echo "<br>" >> "../${file}"

  # next link
  # just for home/index
  if [ "$i" -eq 0 ]; then
    echo "["${titles[i+1]}" {{< fa solid arrow-left >}}](/"${files[i+1]}")" >> "../${file}"
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Added to next article ["${titles[i+1]}"](/"${files[i+1]}")" >&3
  else
    echo "$(date +"%Y-%m-%d %H:%M:%S") - No Article "${titles[i+1]}"](/"${files[i+1]}") found" >&3
  fi
  # next link
  # for all articles
  if [ "$i" -gt 0 ] && [ "$i" -lt "$second_last" ]; then
    echo "["${titles[i+1]} " {{< fa solid arrow-right >}}](/"${files[i+1]}")" >> "../${file}"
    echo "$(date +"%Y-%m-%d %H:%M:%S") - #$: Added article "${titles[i+1]}" to next file ${files[i+1]} to ${file}" >&3
  else
    echo "$(date +"%Y-%m-%d %H:%M:%S") - No next file found for ${file}" >&3
  fi
  # next link
  # just for last page, cards-listing
  if [ "$i" -eq "$second_last" ]; then
    echo "["${titles[0]}" {{< fa solid arrow-left >}}](/"${files[0]}")" >> "../${file}"
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Added article "${titles[0]}" to next file ${files[0]} to ${file}" >&3
  else
    echo "$(date +"%Y-%m-%d %H:%M:%S") - No Articles "${titles[0]}"](/"${files[0]}") found" >&3
  fi
  echo "<br>" >> "../${file}"
  echo "</div>" >> "../${file}"
  echo "<br>" >> "../${file}"
  echo "</div>" >> "../${file}"
done

# Close the log file
exec 3>&-