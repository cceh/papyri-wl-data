#!/bin/bash
#
# Look up xml:ids in literature.xml by short title and output TSV for replace-biblio-ids.sh
# Usage: ./lookup-biblio-ids.sh input.tsv > output.tsv
#
# Input TSV format (tab-separated):
# short_title	new_id
#
# Output TSV format:
# old_id	new_id
#
# Matching is case-insensitive and normalizes whitespace

set -e

if [ $# -ne 1 ]; then
    echo "Usage: $0 <input.tsv> > output.tsv" >&2
    exit 1
fi

INPUT_FILE="$1"
SCRIPT_DIR="$(dirname "$0")"
LITERATURE_FILE="$SCRIPT_DIR/../../meta/literature.xml"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file '$INPUT_FILE' not found" >&2
    exit 1
fi

if [ ! -f "$LITERATURE_FILE" ]; then
    echo "Error: literature.xml not found at '$LITERATURE_FILE'" >&2
    exit 1
fi

# Function to normalize a string: lowercase, collapse whitespace, trim
normalize() {
    echo "$1" | tr '[:upper:]' '[:lower:]' | tr -s '[:space:]' ' ' | sed 's/^ *//;s/ *$//'
}

while IFS=$'\t' read -r short_title new_id || [ -n "$short_title" ]; do
    # Skip empty lines
    [ -z "$short_title" ] && continue

    # Skip lines starting with # (comments)
    [[ "$short_title" =~ ^# ]] && continue

    # Normalize the search title
    search_title=$(normalize "$short_title")

    # Find the xml:id for this short title using grep and sed
    # First find bibl lines with xml:id, then look for matching short title
    old_id=$(grep -B5 "<title type=\"short\">" "$LITERATURE_FILE" | \
        awk -v search="$search_title" '
        /xml:id="/ {
            # Extract xml:id value
            gsub(/.*xml:id="/, "")
            gsub(/".*/, "")
            current_id = $0
        }
        /<title type="short">/ {
            # Extract and normalize title
            gsub(/<[^>]*>/, "")
            gsub(/^[ \t]+|[ \t]+$/, "")
            gsub(/[ \t]+/, " ")
            title = tolower($0)
            if (title == search) {
                print current_id
                exit
            }
        }
        ')

    if [ -n "$old_id" ]; then
        printf '%s\t%s\n' "$old_id" "$new_id"
    else
        echo "Warning: No match found for '$short_title'" >&2
    fi
done < "$INPUT_FILE"
