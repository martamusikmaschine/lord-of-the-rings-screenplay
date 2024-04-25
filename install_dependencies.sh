#!/usr/bin/env bash

set -e
set -u
set -o pipefail

declare -r FONT_URL="https://quoteunquoteapps.com/courierprime/downloads/courier-prime.zip"
declare -r FONT_ZIP_FILE="/tmp/font.zip"
declare -r FONT_FILES="Courier Prime/*.ttf"
declare -r FONT_DIR="/usr/share/fonts"

# quick and dirty way to check if commands exist
curl --version > /dev/null
unzip -v > /dev/null
fc-cache --version > /dev/null

sudo snap install wrap

curl "$FONT_URL" --output "$FONT_ZIP_FILE"

unzip -j "$FONT_ZIP_FILE" "$FONT_FILES" -d "$FONT_DIR"

fc-cache --force
