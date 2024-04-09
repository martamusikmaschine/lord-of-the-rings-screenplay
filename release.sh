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

declare -A MOVIE_TITLES
MOVIE_TITLES["lotr"]="The Motion Picture Trilogy"
MOVIE_TITLES["lotr_1_fotr"]="The Fellowship of the Ring"
MOVIE_TITLES["lotr_2_ttt"]="The two Towers"
MOVIE_TITLES["lotr_3_rotk"]="The Return of the King"
declare -r MOVIE_TITLES

cat_title() {
    sed -e "s/##DRAFTDATE##/$DRAFT_DATE/g" -e "s/##SUBTITLE##/${MOVIE_TITLES[$1]}/g" "$SCENES_DIR/lotr.title.fountain" 
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

movie_scenes_only() {
    cat_title "$1" && find_scenes_only "$1" | sort_and_cat
}

movie_scenes_and_headers() {
    cat_title "$1" && ( find_scenes_only "$1" && find_headers "$1" ) | sort_and_cat
}

lotr_1_fotr_scenes_only() {
    movie_scenes_only "lotr_1_fotr"
}

lotr_1_fotr_scenes_and_headers() {
    movie_scenes_and_headers "lotr_1_fotr"
}

lotr_2_ttt_scenes_only() {
    movie_scenes_only "lotr_2_ttt"
}

lotr_2_ttt_scenes_and_headers() {
    movie_scenes_and_headers "lotr_2_ttt"
}

lotr_3_rotk_scenes_only() {
    movie_scenes_only "lotr_3_rotk"
}

lotr_3_rotk_scenes_and_headers() {
    movie_scenes_and_headers "lotr_3_rotk"
}

lotr_scenes_only() {
    cat_title "lotr" && ( find_scenes_only "lotr_1_fotr" && find_scenes_only "lotr_2_ttt" && find_scenes_only "lotr_3_rotk" ) | sort_and_cat
}

lotr_scenes_and_headers() {
    cat_title "lotr" && ( find_scenes_only "lotr_1_fotr" && find_scenes_only "lotr_2_ttt" && find_scenes_only "lotr_3_rotk" && find_headers "lotr_1_fotr" && find_headers "lotr_2_ttt" && find_headers "lotr_3_rotk" ) | sort_and_cat
}

make_release_filename() {
    local name
    name="$1_screenplay"
    shift

    local dirpart
    dirpart=$(printf '%s/' "${@// /|}")

    local file_extension
    file_extension="$1"
    shift

    local filepart
    filepart=$(printf '_%s' "${@// /|}")

    printf "%s/%s%s%s.%s\n" "$RELEASE_DIR" "$dirpart" "$name" "$filepart" "$file_extension"
}

declare movie 
for movie in "lotr" "lotr_1_fotr" "lotr_2_ttt" "lotr_3_rotk"; do

    for flavor in "scenes_and_headers" "scenes_only"; do

        # create fountain file
        "${movie}_${flavor}" > "$(make_release_filename "$movie" "fountain" "$flavor")"

        # create pdf file
        for page_size in "a4" "letter"; do
            # wrap actually defaults to "letter" if "a4" is not present
            "${movie}_${flavor}" | wrap pdf --page-size "$page_size" -o "$(make_release_filename "$movie" "pdf" "$page_size" "$flavor")"
        done

        # create html file
        "${movie}_${flavor}" | wrap html -o "$(make_release_filename "$movie" "html" "$flavor")"
    done
done
