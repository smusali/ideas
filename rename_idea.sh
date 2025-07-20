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

# Function to update references in a file
update_file_references() {
    local file_path="$1"
    local old_name="$2"
    local new_name="$3"
    local old_filename="$4"
    local new_filename="$5"
    
    if [[ -f "$file_path" ]]; then
        echo "Updating references in $(basename "$file_path")..."
        
        # Replace the idea name (case-sensitive)
        sed -i '' "s/$old_name/$new_name/g" "$file_path"
        
        # Replace the idea name in lowercase
        local old_lower=$(echo "$old_name" | tr '[:upper:]' '[:lower:]')
        local new_lower=$(echo "$new_name" | tr '[:upper:]' '[:lower:]')
        sed -i '' "s/$old_lower/$new_lower/g" "$file_path"
        
        # Replace the idea name in title case (first letter capitalized)
        local old_title=$(echo "$old_name" | sed 's/./\U&/')
        local new_title=$(echo "$new_name" | sed 's/./\U&/')
        sed -i '' "s/$old_title/$new_title/g" "$file_path"
        
        # Replace file references
        sed -i '' "s/$old_filename/$new_filename/g" "$file_path"
        
        echo "✓ $(basename "$file_path") updated"
    else
        echo "⚠ $(basename "$file_path") not found, skipping..."
    fi
}

# Function to sort lists in PROJECT-KEYWORD-GROUPING.md
sort_project_keyword_lists() {
    local file_path="PROJECT-KEYWORD-GROUPING.md"
    
    if [[ ! -f "$file_path" ]]; then
        echo "⚠ $file_path not found, skipping sorting..."
        return
    fi
    
    echo "Sorting lists in $file_path..."
    
    # Create a temporary file
    local temp_file=$(mktemp)
    local current_section=""
    local in_list=false
    local list_items=()
    
    while IFS= read -r line; do
        # Check if we're at a section header
        if [[ "$line" =~ ^##[[:space:]]\*\*.*\*\*$ ]]; then
            # If we were processing a list, sort and output it
            if [[ ${#list_items[@]} -gt 0 ]]; then
                printf '%s\n' "${list_items[@]}" | sort >> "$temp_file"
                list_items=()
            fi
            in_list=false
            echo "$line" >> "$temp_file"
        # Check if we're at a list item
        elif [[ "$line" =~ ^-[[:space:]]\`.*\`[[:space:]]-[[:space:]].* ]]; then
            in_list=true
            list_items+=("$line")
        # Check if we're at the end of a section or file
        elif [[ "$line" =~ ^##[[:space:]][^*].*$ ]] || [[ -z "$line" && $in_list == true ]]; then
            # If we were processing a list, sort and output it
            if [[ ${#list_items[@]} -gt 0 ]]; then
                printf '%s\n' "${list_items[@]}" | sort >> "$temp_file"
                list_items=()
            fi
            in_list=false
            echo "$line" >> "$temp_file"
        else
            # If we were processing a list and this line doesn't continue it
            if [[ $in_list == true && ! "$line" =~ ^-[[:space:]]\`.*\`[[:space:]]-[[:space:]].* ]]; then
                # Sort and output the accumulated list
                printf '%s\n' "${list_items[@]}" | sort >> "$temp_file"
                list_items=()
                in_list=false
            fi
            echo "$line" >> "$temp_file"
        fi
    done < "$file_path"
    
    # Handle any remaining list items at the end of file
    if [[ ${#list_items[@]} -gt 0 ]]; then
        printf '%s\n' "${list_items[@]}" | sort >> "$temp_file"
    fi
    
    # Replace the original file with the sorted version
    mv "$temp_file" "$file_path"
    echo "✓ Lists sorted in $file_path"
}

# Function to sort lists in README.md
sort_readme_lists() {
    local file_path="README.md"
    
    if [[ ! -f "$file_path" ]]; then
        echo "⚠ $file_path not found, skipping sorting..."
        return
    fi
    
    echo "Sorting lists in $file_path..."
    
    # Create a temporary file
    local temp_file=$(mktemp)
    local in_target_section=false
    local list_items=()
    
    while IFS= read -r line; do
        # Check if we're entering a section that should be sorted
        if [[ "$line" =~ ^##[[:space:]]Open-Source[[:space:]]Contributions$ ]] || \
           [[ "$line" =~ ^##[[:space:]]Slack[[:space:]]Workspaces$ ]] || \
           [[ "$line" =~ ^##[[:space:]]Discord[[:space:]]Workspaces$ ]]; then
            # Output any pending list items from previous section
            if [[ ${#list_items[@]} -gt 0 ]]; then
                printf '%s\n' "${list_items[@]}" | sort >> "$temp_file"
                list_items=()
            fi
            in_target_section=true
            echo "$line" >> "$temp_file"
        # Check if we're leaving a target section
        elif [[ "$line" =~ ^##[[:space:]].* ]] && [[ $in_target_section == true ]]; then
            # Sort and output accumulated list items
            if [[ ${#list_items[@]} -gt 0 ]]; then
                printf '%s\n' "${list_items[@]}" | sort >> "$temp_file"
                list_items=()
            fi
            in_target_section=false
            echo "$line" >> "$temp_file"
        # Check if we're at a list item in a target section
        elif [[ $in_target_section == true && "$line" =~ ^-[[:space:]].* ]]; then
            list_items+=("$line")
        else
            # If we were processing a list and this line doesn't continue it
            if [[ $in_target_section == true && ${#list_items[@]} -gt 0 && ! "$line" =~ ^-[[:space:]].* ]]; then
                # Sort and output the accumulated list
                printf '%s\n' "${list_items[@]}" | sort >> "$temp_file"
                list_items=()
                in_target_section=false
            fi
            echo "$line" >> "$temp_file"
        fi
    done < "$file_path"
    
    # Handle any remaining list items at the end of file
    if [[ ${#list_items[@]} -gt 0 ]]; then
        printf '%s\n' "${list_items[@]}" | sort >> "$temp_file"
    fi
    
    # Replace the original file with the sorted version
    mv "$temp_file" "$file_path"
    echo "✓ Lists sorted in $file_path"
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

# Step 3: Update references in documentation files
echo "Step 3: Updating references in documentation files..."

# Update README.md
update_file_references "README.md" "$OLD_IDEANAME" "$NEW_IDEANAME" "$OLD_FILENAME" "$NEW_FILENAME"

# Update OSS-MICROSAAS-RELATIONSHIPS.md
update_file_references "OSS-MICROSAAS-RELATIONSHIPS.md" "$OLD_IDEANAME" "$NEW_IDEANAME" "$OLD_FILENAME" "$NEW_FILENAME"

# Update PROJECT-KEYWORD-GROUPING.md
update_file_references "PROJECT-KEYWORD-GROUPING.md" "$OLD_IDEANAME" "$NEW_IDEANAME" "$OLD_FILENAME" "$NEW_FILENAME"

echo ""

# Step 4: Sort lists alphabetically in documentation files
echo "Step 4: Sorting lists alphabetically in documentation files..."

# Sort lists in README.md
sort_readme_lists

# Sort lists in PROJECT-KEYWORD-GROUPING.md
sort_project_keyword_lists

echo ""
echo "Rename and sorting process completed successfully!"
echo ""

# Step 5: Verification
echo "Step 5: Verification..."

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
echo "Rename and sorting process completed! 🎉" 