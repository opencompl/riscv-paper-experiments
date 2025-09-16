#!/usr/bin/awk -f

function get_path_components(path) {
    # Split the path into components
    n = split(path, parts, "/")

    # Extract the required components
    variant = parts[n]
    params = (n > 1) ? parts[n-1] : ""
    impl = (n > 2) ? parts[n-2] : ""

    # Remove the extension from variant
    sub("\\.[^.]*$", "", variant)

    return variant "," params "," impl
}

/# Regalloc stats:/ {
    match($0, /\{.*\}/)
    if (RLENGTH > 0) {
        json = substr($0, RSTART, RLENGTH)
        # Remove the closing brace
        sub(/}$/, "", json)

        # Get path components
        split(get_path_components(FILENAME), components, ",")
        variant = components[1]
        params = components[2]
        impl = components[3]

        # Add new fields and close the brace
        printf "%s, \"variant\": \"%s\", \"params\": \"%s\", \"impl\": \"%s\"}\n",
               json, variant, params, impl
    }
}
