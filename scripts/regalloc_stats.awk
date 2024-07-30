#!/usr/bin/awk -f

function get_stem(path) {
    # Remove everything up to the last "/"
    sub(".*/", "", path)
    # Remove the extension
    sub("\\.[^.]*$", "", path)
    return path
}

/# Regalloc stats:/ {
    match($0, /\{.*\}/)
    if (RLENGTH > 0) {
        json = substr($0, RSTART, RLENGTH)
        # Remove the closing brace, add the filename stem, and close the brace again
        sub(/}$/, "", json)
        stem = get_stem(FILENAME)
        printf "%s, \"test\": \"%s\"}\n", json, stem
    }
}
