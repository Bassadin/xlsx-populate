#!/bin/bash
set -e -u -o pipefail

indent_folder() {
    local root=$1
    find "$root" -name '*.xml' -o -name '*.vml' | while read -r file; do
        if test -s "$file"; then
            < "$file" xmllint --format - | sponge "$file"
        fi
    done
}


main() {
    local file=$1
    name=$(basename "${file%.*}")
    unzip -q -o -d "$name" "$file"
    indent_folder "$name"
    echo "$file -> $name/"
}

main "$@"
