#!/usr/bin/env bash
if [ $# -lt 2 ]; then
    echo >&2 "usage: $0 <input folder> <output folder>"
    exit 1
fi

_in="${1%%/}"; shift
_out="${1%%/}"; shift

set -eo pipefail
for inf in $(find "${_in}" -maxdepth 1 -type f); do
    echo >&2 "processing ${inf##*/} ..."
    ext="${inf##*.}"
    ext="${ext,,}"
    [ "${ext}" = "jpeg" ] && ext="jpg"

    tmpf="${_out}/tconv_${inf##*/}"
    cp "${inf}" "${tmpf}"

    if (( $(identify -format '%[fx:(h>600 || w>600)]' "${tmpf}") )); then
        mogrify -resize '600x600>' "${tmpf}"
    fi

    if [ "${ext}" = jpg ]; then
        exiftool -q -overwrite_original -all= --ICC_Profile:all "${tmpf}"
        jpegoptim -q "${tmpf}"
    fi

    hsh="$(sha1sum "${tmpf}" | cut -d' ' -f1)"
    mv "${tmpf}" "${_out}/${hsh}.${ext}"
    echo >&2 "... to ${hsh}.${ext}"
done
