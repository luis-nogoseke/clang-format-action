#!/usr/bin/env sh

###############################################################################
#                                entrypoint.sh                                #
###############################################################################
# Checks all C/C++ files (.c, .cpp, .cc, .h and .hpp) in the GitHub workspace
# for conforming to clang-format. If any C files are incorrectly formatted, the
# script lists them and exits with 1.
# Define your own formatting rules in a .clang-format file at your repository
# root. Otherwise, the LLVM style guide is used as a default.

###############################################################################
#                             format_diff function                            #
###############################################################################
# Accepts a filepath argument. The filepath passed to this function must point
# to a C or C++ file. The file is formatted with clang-format and that output
# is compared to the original file.
format_diff(){
    local filepath="$1"
    local_format="$(/usr/bin/clang-format -n --Werror --style=file --fallback-style=Google "${filepath}")"
    local format_status="$?"
    if [[ "${format_status}" -ne 0 ]]; then
        echo "$local_format" >&2
        exit_code=1
        return "${format_status}"
    fi
    return 0
}

cd "$GITHUB_WORKSPACE" || exit 2

# initialize exit code
exit_code=0

# All files improperly formatted will be printed to the output.
# find all C/C++ files
c_files=$(find -regex '.*/.*\.\(c\|cpp\|h\|hpp\|cc\)$')

# check formatting in each C file
for file in $c_files; do
    format_diff "${file}"
done

exit "$exit_code"
