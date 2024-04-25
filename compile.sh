#!/usr/bin/env bash

set -e
set -u
set -o pipefail

declare PROJECT_ROOT
PROJECT_ROOT=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
declare -r PROJECT_ROOT

# quick and dirty way to check if commands exist
find --help > /dev/null
sort --version > /dev/null
xargs --version > /dev/null
cat --version > /dev/null
wrap version > /dev/null
sed --version > /dev/null
date --version > /dev/null
cut --version > /dev/null

declare COMPILATION_DIR
COMPILATION_DIR="$PROJECT_ROOT/compilation"
declare -r COMPILATION_DIR

declare RELEASE_DIR
RELEASE_DIR="$PROJECT_ROOT/release"
declare -r RELEASE_DIR

declare SCENES_DIR
SCENES_DIR="$PROJECT_ROOT/scenes"
declare -r SCENES_DIR

declare DRAFT_DATE
DRAFT_DATE="$(date +%Y-%m-%d)"
if [ "${GITHUB_REF:-}" != "" ]; then
    DRAFT_DATE="${GITHUB_REF:10}, $DRAFT_DATE"
fi
declare -r DRAFT_DATE

declare -A MOVIE_SUBTITLES
MOVIE_SUBTITLES["lotr"]="The Motion Picture Trilogy"
MOVIE_SUBTITLES["lotr_1_fotr"]="The Fellowship of the Ring"
MOVIE_SUBTITLES["lotr_2_ttt"]="The two Towers"
MOVIE_SUBTITLES["lotr_3_rotk"]="The Return of the King"
declare -r MOVIE_SUBTITLES

declare -r LOTR_SCRIPT_PDF="$COMPILATION_DIR/pdf/letter/scenes_no_headers/Screenplay-The_Lord_of_the_Rings-The_Motion_Picture_Trilogy-scenes_no_headers-letter.pdf"

cat_title() {
    sed -e "s/##DRAFTDATE##/$DRAFT_DATE/g" -e "s/##SUBTITLE##/${MOVIE_SUBTITLES[$1]}/g" "$SCENES_DIR/lotr.title.fountain" 
}

sort_and_cat() {
    sort | cut -d " " -f 2 | xargs cat
}

find_fountain() {
    find "$@" -type f -name "*.fountain" -printf "%f %p\n"
}

find_scenes_no_headers() {
    find_fountain "$SCENES_DIR/$1/production"
}

find_headers() {
    find_fountain "$SCENES_DIR/$1/header"
}

cat_movie_scenes_no_headers() {
    cat_title "$1" && find_scenes_no_headers "$1" | sort_and_cat
}

cat_movie_scenes_and_headers() {
    cat_title "$1" && ( find_scenes_no_headers "$1" && find_headers "$1" ) | sort_and_cat
}

cat_lotr_1_fotr_scenes_no_headers() {
    cat_movie_scenes_no_headers "lotr_1_fotr"
}

cat_lotr_1_fotr_scenes_and_headers() {
    cat_movie_scenes_and_headers "lotr_1_fotr"
}

cat_lotr_2_ttt_scenes_no_headers() {
    cat_movie_scenes_no_headers "lotr_2_ttt"
}

cat_lotr_2_ttt_scenes_and_headers() {
    cat_movie_scenes_and_headers "lotr_2_ttt"
}

cat_lotr_3_rotk_scenes_no_headers() {
    cat_movie_scenes_no_headers "lotr_3_rotk"
}

cat_lotr_3_rotk_scenes_and_headers() {
    cat_movie_scenes_and_headers "lotr_3_rotk"
}

cat_lotr_scenes_no_headers() {
    cat_title "lotr" && ( find_scenes_no_headers "lotr_1_fotr" && find_scenes_no_headers "lotr_2_ttt" && find_scenes_no_headers "lotr_3_rotk" ) | sort_and_cat
}

cat_lotr_scenes_and_headers() {
    cat_title "lotr" && ( find_scenes_no_headers "lotr_1_fotr" && find_scenes_no_headers "lotr_2_ttt" && find_scenes_no_headers "lotr_3_rotk" && find_headers "lotr_1_fotr" && find_headers "lotr_2_ttt" && find_headers "lotr_3_rotk" ) | sort_and_cat
}

print_table_header() {
    printf " |------------------------------------------------------|\n"
    printf " | %-2s | %-11s | %-18s | %-12s |\n" "#" "Movie" "Flavor" "Format"
    printf " |----+-------------+--------------------+--------------|\n"
}

print_table_row() {
    printf " | %-2d | %-11s | %-18s | %-12s |\n" "$compilation_file_count" "$movie" "$flavor" "$format"
}

# We start at 1 so we can use ((compilation_file_count++)) which fails if compilation_file_count is 0
declare -i compilation_file_count=1

declare current_compilation_filename

declare -A COMPILATION_DIRECTORIES

make_compilation_filename() {
    local -r file_extension="$1"
    shift

    local target_dir="$file_extension/${*// /|}/$flavor"

    local format="$file_extension"

    local more_flavor=""

    if [ $# -eq 1 ]; then
        format="$format ($1)"
        more_flavor="-$1"
    fi

    COMPILATION_DIRECTORIES["$target_dir"]="Screenplay-The_Lord_of_the_Rings-${flavor}-${file_extension}${more_flavor}.zip"
    target_dir="$COMPILATION_DIR/$target_dir"

    mkdir -p "$target_dir"

    declare -r movie_title="The_Lord_of_the_Rings-${MOVIE_SUBTITLES[$movie]// /_}"

    current_compilation_filename="$target_dir/Screenplay-${movie_title}-${flavor}${more_flavor}.${file_extension}"
    ((compilation_file_count++))

    print_table_row
}

main() {
    printf "Removing compilation directory.\n"
    rm -rf "$COMPILATION_DIR" || true

    local movie flavor

    printf "Compiling screenplay.\n\n"
    print_table_header

    for movie in "lotr" "lotr_1_fotr" "lotr_2_ttt" "lotr_3_rotk"; do
        for flavor in "scenes_and_headers" "scenes_no_headers"; do

            make_compilation_filename "pdf" "a4"
            "cat_${movie}_${flavor}" | wrap pdf --page-size "a4" -o "$current_compilation_filename"

            make_compilation_filename "pdf" "letter"
            "cat_${movie}_${flavor}" | wrap pdf --page-size "letter" -o "$current_compilation_filename"

            make_compilation_filename "html"
            "cat_${movie}_${flavor}" | wrap html -o "$current_compilation_filename"

            make_compilation_filename "fountain"
            "cat_${movie}_${flavor}" > "$current_compilation_filename"

        done
    done

    printf " |------------------------------------------------------|\n"
    printf "\nAll files compiled.\n"

    if [ "${1:-}" = "release" ]; then

        printf "\nRemoving release directory.\n"
        rm -rf "$RELEASE_DIR" || true

        mkdir "$RELEASE_DIR"

        printf "Copying main screenplay pdf file.\n"
        cp "$PROJECT_ROOT/RELEASE.md" "$LOTR_SCRIPT_PDF" "$RELEASE_DIR"

        printf "Creation version file.\n"
        printf "# DATE\n%s\n\n# VERSION\n%s\n" "$(date -u +'%Y-%m-%dT%H:%M:%SZ')" "${GITHUB_REF:-local}" >> "$COMPILATION_DIR/VERSION.md"

        printf "Compressing release directories.\n\n"
        local zip_file_name single_compilation_dir compress_dir

        for single_compilation_dir in "${!COMPILATION_DIRECTORIES[@]}"; do
            zip_file_name="${COMPILATION_DIRECTORIES["$single_compilation_dir"]}"

            compress_dir="$COMPILATION_DIR/$single_compilation_dir"

            cp "$COMPILATION_DIR/VERSION.md" "$PROJECT_ROOT/RELEASE.md" "$PROJECT_ROOT/LICENSE-CC-BY-NC-ND-4.0.md" "$compress_dir"

            zip -q -r -j "$RELEASE_DIR/$zip_file_name" "$compress_dir"
            printf "%s\n" "$zip_file_name"
        done

        printf "\nAll files compressed.\n"

    fi

    printf "\nSuccess.\n\n"

}

main "$@"
