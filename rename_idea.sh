#!/bin/bash

# rename_idea.sh - Script to rename idea files and update content references
# Usage: ./rename_idea.sh --folder <folder> --old-filename <old.md> --old-ideaname <OldName> --new-filename <new.md> --new-ideaname <NewName>

set -e  # Exit on any error

# Default values
FOLDER=""
OLD_FILENAME=""
OLD_IDEANAME=""
NEW_FILENAME=""
NEW_IDEANAME=""

# Function to display usage
show_usage() {
    echo "Usage: $0 --folder <folder> --old-filename <old.md> --old-ideaname <OldName> --new-filename <new.md> --new-ideaname <NewName>"
    echo ""
    echo "Arguments:"
    echo "  --folder <folder>        Target folder (e.g., microsaas, oss)"
    echo "  --old-filename <old.md>  Current markdown filename"
    echo "  --old-ideaname <OldName> Current idea name in content"
    echo "  --new-filename <new.md>  New markdown filename"
    echo "  --new-ideaname <NewName> New idea name for content"
    echo ""
    echo "Example:"
    echo "  $0 --folder microsaas --old-filename aetheris.md --old-ideaname Aetheris --new-filename nebulis.md --new-ideaname Nebulis"
    exit 1
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --folder)
            FOLDER="$2"
            shift 2
            ;;
        --old-filename)
            OLD_FILENAME="$2"
            shift 2
            ;;
        --old-ideaname)
            OLD_IDEANAME="$2"
            shift 2
            ;;
        --new-filename)
            NEW_FILENAME="$2"
            shift 2
            ;;
        --new-ideaname)
            NEW_IDEANAME="$2"
            shift 2
            ;;
        -h|--help)
            show_usage
            ;;
        *)
            echo "Unknown option: $1"
            show_usage
            ;;
    esac
done

# Validate required arguments
if [[ -z "$FOLDER" || -z "$OLD_FILENAME" || -z "$OLD_IDEANAME" || -z "$NEW_FILENAME" || -z "$NEW_IDEANAME" ]]; then
    echo "Error: All arguments are required!"
    show_usage
fi

# Check if folder exists
if [[ ! -d "$FOLDER" ]]; then
    echo "Error: Folder '$FOLDER' does not exist!"
    exit 1
fi

# Check if old file exists
OLD_FILE_PATH="$FOLDER/$OLD_FILENAME"
if [[ ! -f "$OLD_FILE_PATH" ]]; then
    echo "Error: File '$OLD_FILE_PATH' does not exist!"
    exit 1
fi

# Check if new file already exists
NEW_FILE_PATH="$FOLDER/$NEW_FILENAME"
if [[ -f "$NEW_FILE_PATH" ]]; then
    echo "Error: File '$NEW_FILE_PATH' already exists!"
    exit 1
fi

echo "Starting idea rename process..."
echo "Folder: $FOLDER"
echo "Old file: $OLD_FILENAME -> New file: $NEW_FILENAME"
echo "Old idea name: $OLD_IDEANAME -> New idea name: $NEW_IDEANAME"
echo ""

# Step 1: Rename the markdown file
echo "Step 1: Renaming file from $OLD_FILENAME to $NEW_FILENAME..."
mv "$OLD_FILE_PATH" "$NEW_FILE_PATH"
echo "✓ File renamed successfully"

# Step 2: Update content in the renamed file
echo "Step 2: Updating content in $NEW_FILENAME..."

# Replace the idea name (case-sensitive)
sed -i '' "s/$OLD_IDEANAME/$NEW_IDEANAME/g" "$NEW_FILE_PATH"

# Replace the idea name in lowercase
OLD_LOWER=$(echo "$OLD_IDEANAME" | tr '[:upper:]' '[:lower:]')
NEW_LOWER=$(echo "$NEW_IDEANAME" | tr '[:upper:]' '[:lower:]')
sed -i '' "s/$OLD_LOWER/$NEW_LOWER/g" "$NEW_FILE_PATH"

# Replace the idea name in title case (first letter capitalized)
OLD_TITLE=$(echo "$OLD_IDEANAME" | sed 's/./\U&/')
NEW_TITLE=$(echo "$NEW_IDEANAME" | sed 's/./\U&/')
sed -i '' "s/$OLD_TITLE/$NEW_TITLE/g" "$NEW_FILE_PATH"

echo "✓ Content updated in $NEW_FILENAME"

# Step 3: Update README.md references
echo "Step 3: Updating references in README.md..."

if [[ -f "README.md" ]]; then
    # Replace idea name references (case-sensitive)
    sed -i '' "s/$OLD_IDEANAME/$NEW_IDEANAME/g" "README.md"
    
    # Replace idea name references in lowercase
    sed -i '' "s/$OLD_LOWER/$NEW_LOWER/g" "README.md"
    
    # Replace file references
    sed -i '' "s/$OLD_FILENAME/$NEW_FILENAME/g" "README.md"
    
    echo "✓ README.md updated"
else
    echo "⚠ README.md not found, skipping..."
fi

echo ""
echo "Rename process completed successfully!"
echo ""

# Step 4: Verification
echo "Step 4: Verification..."

# Check if the new file exists
if [[ -f "$NEW_FILE_PATH" ]]; then
    echo "✓ New file exists: $NEW_FILE_PATH"
else
    echo "✗ Error: New file not found!"
    exit 1
fi

# Check for any remaining references to the old name
echo "Checking for any remaining references to old names..."
OLD_REFS=$(grep -r "$OLD_IDEANAME" . --exclude-dir=.git 2>/dev/null || true)
OLD_FILE_REFS=$(grep -r "$OLD_FILENAME" . --exclude-dir=.git 2>/dev/null || true)

if [[ -n "$OLD_REFS" ]]; then
    echo "⚠ Warning: Found remaining references to old idea name '$OLD_IDEANAME':"
    echo "$OLD_REFS"
else
    echo "✓ No remaining references to old idea name found"
fi

if [[ -n "$OLD_FILE_REFS" ]]; then
    echo "⚠ Warning: Found remaining references to old filename '$OLD_FILENAME':"
    echo "$OLD_FILE_REFS"
else
    echo "✓ No remaining references to old filename found"
fi

echo ""
echo "Rename process completed! 🎉" 