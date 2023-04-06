#!/bin/bash

# Usage: ./img-analyze.sh <directory> [<filetype1> <filetype2> ...]

# Check if directory exists
if [ ! -d "$1" ]; then
    echo "Directory does not exist"
    exit 1
fi

# Get all file types that follow
if [ $# -eq 1 ]; then
    filetypes="tsx jsx html htm"
else
    filetypes="${@:2}"
fi

# Build a regex pattern for find command
regex=""
for filetype in $filetypes
do
    regex+=" -o -name \"*.$filetype\""
done
regex=${regex#" -o"}

# Create HTML file name with timestamp
timestamp=$(date +%Y%m%d)
html_file="AltStatusSummary_${timestamp}.html"

# Create HTML file with document title and h1
echo "<!DOCTYPE html>" > $html_file
echo "<html lang=en>" >> $html_file
echo "<head>" >> $html_file
echo "<title>Alt Attribute Analysis</title>" >> $html_file
echo '<style type="text/css">' >> $html_file
echo '  dl {' >> $html_file
echo '    display: flex;' >> $html_file
echo '    flex-flow: row wrap;' >> $html_file
echo '    border: solid #333;' >> $html_file
echo '    border-width: 1px 1px 0 0;' >> $html_file
echo '  }' >> $html_file
echo '  dt {' >> $html_file
echo '    flex-basis: 20%;' >> $html_file
echo '    padding: 2px 4px;' >> $html_file
echo '    background: #333;' >> $html_file
echo '    text-align: right;' >> $html_file
echo '    color: #fff;' >> $html_file
echo '  }' >> $html_file
echo '  dd {' >> $html_file
echo '    flex-basis: 70%;' >> $html_file
echo '    flex-grow: 1;' >> $html_file
echo '    margin: 0;' >> $html_file
echo '    padding: 2px 4px;' >> $html_file
echo '    border-bottom: 1px solid #333;' >> $html_file
echo '  }' >> $html_file
echo ' @media print {' >> $html_file
echo '  dl { border: 0 none }' >> $html_file
echo '  dd { border-bottom: 0 none }' >> $html_file
echo '  dt {' >> $html_file]
echo '    background: none;' >> $html_file
echo '    color: #111;' >> $html_file
echo '  }' >> $html_file
echo ' }' >> $html_file
echo '</style>' >> $html_file
echo "</head>" >> $html_file
echo "<body>" >> $html_file
echo "<h1>Alt Text Summary</h1>" >> $html_file

echo find "$1" -type f \( $regex \);
# # Iterate through each filename with img element present
    # for filename in $(find "$1" -type f \( $regex \)); do
    for filename in $(grep -rl "<img" "$1"); do
        
        if [[ $filename != *.sh ]]; then            
            # Add H2 of filename with count of img elements to HTML file
            echo "<h2>$filename</h2>" >> $html_file

            file_contents=$(cat "$filename")

            # Remove newline characters
            file_contents=$(echo "$file_contents" | tr -d '\n\t')

            # Extract all of the <img> tags
            img_tags=$(echo "$file_contents" | grep -o '<img[^>]*>') 

            # Iterate over img_tags using null character as delimiter
            while IFS= read -r -d '' img_tag; do
                # Do something with each img_tag
                echo "$img_tag"
            done <<< "$img_tags"

            img_tags2=""
            for img in $img_tags; do
                img_tags2+="$img "
            done

            # Extract all of the <img> tags
            img_tags=$(echo "$img_tags2" | awk -F'<img ' '{for(i=2;i<=NF;i++) print "<img " $i}')

            #Iterate over each image tag
            while read -r img_tag; do
                img_tag=$(echo "$img_tag" | tr -s ' ')
                echo "<article>$img_tag</article>" >> $html_file
            done <<< "$img_tags"

        fi
    done

# Will parse and create data-list
echo '<script src="img-checklist.js"></script>' >> $html_file

# Close HTML file body and html tags
echo "</body>" >> $html_file
echo "</html>" >> $html_file

# Notify Script runner file created and where they can find it
echo "HTML file created: ${html_file}"
