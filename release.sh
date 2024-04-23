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

declare RELEASE_DIR
RELEASE_DIR="$PROJECT_ROOT/release"
declare -r RELEASE_DIR

declare SCENES_DIR
SCENES_DIR="$PROJECT_ROOT/scenes"
declare -r SCENES_DIR

declare DRAFT_DATE
DRAFT_DATE="$(date +%Y-%m-%d)"
declare -r DRAFT_DATE

declare -A MOVIE_SUBTITLES
MOVIE_SUBTITLES["lotr"]="The Motion Picture Trilogy"
MOVIE_SUBTITLES["lotr_1_fotr"]="The Fellowship of the Ring"
MOVIE_SUBTITLES["lotr_2_ttt"]="The two Towers"
MOVIE_SUBTITLES["lotr_3_rotk"]="The Return of the King"
declare -r MOVIE_SUBTITLES

cat_title() {
    sed -e "s/##DRAFTDATE##/$DRAFT_DATE/g" -e "s/##SUBTITLE##/${MOVIE_SUBTITLES[$1]}/g" "$SCENES_DIR/lotr.title.fountain" 
}

sort_and_cat() {
    sort | cut -d " " -f 2 | xargs cat
}

find_fountain() {
    find "$@" -type f -name "*.fountain" -printf "%f %p\n"
}

find_scenes_only() {
    find_fountain "$SCENES_DIR/$1/production"
}

find_headers() {
    find_fountain "$SCENES_DIR/$1/header"
}

cat_movie_scenes_only() {
    cat_title "$1" && find_scenes_only "$1" | sort_and_cat
}

cat_movie_scenes_and_headers() {
    cat_title "$1" && ( find_scenes_only "$1" && find_headers "$1" ) | sort_and_cat
}

cat_lotr_1_fotr_scenes_only() {
    cat_movie_scenes_only "lotr_1_fotr"
}

cat_lotr_1_fotr_scenes_and_headers() {
    cat_movie_scenes_and_headers "lotr_1_fotr"
}

cat_lotr_2_ttt_scenes_only() {
    cat_movie_scenes_only "lotr_2_ttt"
}

cat_lotr_2_ttt_scenes_and_headers() {
    cat_movie_scenes_and_headers "lotr_2_ttt"
}

cat_lotr_3_rotk_scenes_only() {
    cat_movie_scenes_only "lotr_3_rotk"
}

cat_lotr_3_rotk_scenes_and_headers() {
    cat_movie_scenes_and_headers "lotr_3_rotk"
}

cat_lotr_scenes_only() {
    cat_title "lotr" && ( find_scenes_only "lotr_1_fotr" && find_scenes_only "lotr_2_ttt" && find_scenes_only "lotr_3_rotk" ) | sort_and_cat
}

cat_lotr_scenes_and_headers() {
    cat_title "lotr" && ( find_scenes_only "lotr_1_fotr" && find_scenes_only "lotr_2_ttt" && find_scenes_only "lotr_3_rotk" && find_headers "lotr_1_fotr" && find_headers "lotr_2_ttt" && find_headers "lotr_3_rotk" ) | sort_and_cat
}

print_table_header() {
    printf " |------------------------------------------------------|\n"
    printf " | %-2s | %-11s | %-18s | %-12s |\n" "#" "Movie" "Flavor" "Format"
    printf " |----+-------------+--------------------+--------------|\n"
}

print_table_row() {
    printf " | %-2d | %-11s | %-18s | %-12s |\n" "$release_file_count" "$movie" "$flavor" "$format"
}

# We start at 1 so we can use ((foo++)) which fails if foo is 0
declare -i release_file_count=1

declare current_release_filename

declare -A release_directories

make_release_filename() {
    local -r file_extension="$1"
    shift

    local target_dir="$file_extension/${*// /|}/$flavor"

    local format="$file_extension"

    local more_flavor=""

    if [ $# -eq 1 ]; then
        format="$format ($1)"
        more_flavor="-$1"
    fi

    release_directories["$target_dir"]="Screenplay-The_Lord_of_the_Rings-${flavor}-${file_extension}${more_flavor}.zip"
    target_dir="$RELEASE_DIR/$target_dir"

    mkdir -p "$target_dir"

    declare -r movie_title="The_Lord_of_the_Rings-${MOVIE_SUBTITLES[$movie]// /_}"

    current_release_filename="$target_dir/Screenplay-${movie_title}-${flavor}${more_flavor}.${file_extension}"
    ((release_file_count++))

    print_table_row
}

main() {
    printf "Removing release directory.\n"
    rm -rf "$RELEASE_DIR" || true

    local movie flavor

    printf "Compiling screenplay.\n\n"
    print_table_header

    for movie in "lotr" "lotr_1_fotr" "lotr_2_ttt" "lotr_3_rotk"; do
        for flavor in "scenes_and_headers" "scenes_only"; do

            make_release_filename "pdf" "a4"
            "cat_${movie}_${flavor}" | wrap pdf --page-size "a4" -o "$current_release_filename"

            make_release_filename "pdf" "letter"
            "cat_${movie}_${flavor}" | wrap pdf --page-size "letter" -o "$current_release_filename"

            make_release_filename "html"
            "cat_${movie}_${flavor}" | wrap html -o "$current_release_filename"

            make_release_filename "fountain"
            "cat_${movie}_${flavor}" > "$current_release_filename"

        done
    done

    printf " |------------------------------------------------------|\n"
    printf "\nAll files compiled.\n"

    if [ "${1:-}" = "compress" ]; then

        mkdir "$RELEASE_DIR/zip"

        printf "# DATE\n%s\n\n# VERSION\n%s\n" "$(date -u +'%Y-%m-%dT%H:%M:%SZ')" "${GITHUB_REF:-local}" >> "$RELEASE_DIR/VERSION.md"

        printf "\nCompressing release directories.\n\n"
        local zip_file_name foo compress_dir

        for foo in "${!release_directories[@]}"; do
            zip_file_name="${release_directories["$foo"]}"

            compress_dir="$RELEASE_DIR/$foo"

            cp "$RELEASE_DIR/VERSION.md" "$PROJECT_ROOT/RELEASE.md" "$PROJECT_ROOT/LICENSE-CC-BY-NC-ND-4.0.md" "$compress_dir"

            zip -q -r -j "$RELEASE_DIR/zip/$zip_file_name" "$compress_dir"
            printf "%s\n" "$zip_file_name"
        done

        printf "\nAll files compressed.\n"
    fi

}

main "$@"
