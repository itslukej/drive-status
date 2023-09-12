FILE="status.txt"

salt '*' cmd.run 'zpool status' | grep 'ata-' | sort > status.txt

if [ ! -f "$FILE" ]; then
    echo "Error: File $FILE does not exist."
    exit 1
fi

# Check if the file has changes
if git diff --quiet HEAD -- "$FILE"; then
    echo "No changes detected in $FILE."
else
    git add "$FILE"
    git commit -m "Updated $FILE"
    echo "Committed changes in $FILE."
    git push
fi
