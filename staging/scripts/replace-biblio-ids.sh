#!/bin/bash
#
# Replace bibliographic xml:ids in meta/*.xml based on TSV input
# Usage: ./replace-biblio-ids.sh input.tsv
#
# TSV format (tab-separated, no header):
# old_id	new_id
#
# Replaces in all XML files in meta/:
# - xml:id="old_id" -> xml:id="new_id"
# - target="old_id" -> target="new_id"
# - target="#old_id" -> target="#new_id"

set -e

if [ $# -ne 1 ]; then
    echo "Usage: $0 <input.tsv>"
    exit 1
fi

TSV_FILE="$1"
SCRIPT_DIR="$(dirname "$0")"
META_DIR="$SCRIPT_DIR/../../meta"

if [ ! -f "$TSV_FILE" ]; then
    echo "Error: TSV file '$TSV_FILE' not found"
    exit 1
fi

XML_FILES=("$META_DIR"/*.xml)
if [ ${#XML_FILES[@]} -eq 0 ]; then
    echo "Error: No XML files found in '$META_DIR'"
    exit 1
fi

echo "Processing replacements from $TSV_FILE..."
echo "XML files: ${XML_FILES[*]}"

count=0
while IFS=$'\t' read -r old_id new_id || [ -n "$old_id" ]; do
    # Skip empty lines
    [ -z "$old_id" ] && continue

    # Skip lines starting with # (comments)
    [[ "$old_id" =~ ^# ]] && continue

    echo "Replacing: $old_id -> $new_id"

    for xml_file in "${XML_FILES[@]}"; do
        # Replace xml:id="old_id"
        sed -i '' "s/xml:id=\"${old_id}\"/xml:id=\"${new_id}\"/g" "$xml_file"

        # Replace target="old_id" (without #)
        sed -i '' "s/target=\"${old_id}\"/target=\"${new_id}\"/g" "$xml_file"

        # Replace target="#old_id" (with #)
        sed -i '' "s/target=\"#${old_id}\"/target=\"#${new_id}\"/g" "$xml_file"
    done

    ((count++))
done < "$TSV_FILE"

echo "Done. Processed $count replacements."
