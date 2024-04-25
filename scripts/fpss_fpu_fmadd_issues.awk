#!/usr/bin/awk -f
# Count the number of fmadd.* instructions issued for each
# profile section and output results in JSON format.

BEGIN {
    RS = "\n"
    section = 0
}

/fmadd\.[fd]/{
    counter[section]++
}

/csrr.+mcycle/{
    section++
    counter[section] = 0
}

END {
    # JSON
    # printf "[\n"
    # for (i = 0; i <= section; i++) {
    #     printf "  { \"fpss_fpu_fmadd_issues\": %d }", counter[i]
    #     if (i < section) printf ","
    #     printf "\n"
    # }
    # printf "]\n"

    # CSV
    printf "fpss_fpu_fmadd_issues\n"
    for (i = 0; i <= section; i++) {
        printf "%d\n", counter[i]
    }
}
