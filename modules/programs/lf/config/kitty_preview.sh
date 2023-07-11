#!/usr/bin/env bash
file=$1
w=$2
h=$3
x=$4
y=$5

preview() {
    kitty +kitten icat --silent --stdin no --transfer-mode file --place "${w}x${h}@${x}x${y}" "$1" < /dev/null > /dev/tty
}

TEMPDIR=$HOME/.cache

file="$1"; shift
case "$(basename "$file" | tr '[A-Z]' '[a-z]')" in
    *.tar*) tar tf "$file" ;;
    *.zip) unzip -l "$file" ;;
    *.rar) unrar l "$file" ;;
    *.7z) 7z l "$file" ;;
    *.py) bat -l python "$file" ;;
    *.sh) bat -l zsh "$file" ;;
    *.nix) bat -l nix "$file" ;;
    *.ipynb) bat -l json "$file" ;;
    *.txt) bat "$file" ;;
    *.json) bat -l json "$file" ;;
    *.md) bat -l markdown "$file" ;;
    *.avi|*.mp4|*.mkv|*.ts)
        thumbnail="$TEMPDIR/thumbnail.png"
        ffmpeg -y -i "$file" -vframes 1 "$thumbnail"
        preview "$thumbnail"
        ;;
    *.pdf)
        thumbnail="$TEMPDIR/thumbnail.png"
        gs -o "$thumbnail" -sDEVICE=pngalpha -dLastPage=1 "$file" >/dev/null
        preview "$thumbnail"
        ;;
    *.jpg|*.jpeg|*.png|*.bmp)
        preview "$file"
        ;;
    *.ttf|*.otf|*.woff)
        thumbnail="$TEMPDIR/thumbnail.png"
        fontpreview -i "$file" -o "$thumbnail"
        preview "$thumbnail"
        ;;
    text/html) lynx -width="$4" -display_charset=utf-8 -dump "$1" ;;
    text/troff) man ./ "$1" | col -b ;;
    text/* | */xml | application/json) bat --terminal-width "$(($4-2))" -f "$1" ;;
    audio/* | application/octet-stream) mediainfo "$1" || exit 1 ;;
    *.svg)
        thumbnail="$TEMPDIR/thumbnail.png"
        convert "$file" "$thumbnail"
        preview "$thumbnail"
        ;;
    *) lf_bat_preview "$file" ;;
esac
return 0 # nonzero retcode required for lf previews to reload
