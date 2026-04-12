#!/bin/sh
set -eu

# this is needed mostly because $DESTDIR is provided as a variable,
# and we need to create the target directory...

_os="$(
  uname \
    -o)"

_global_variables() {
  _target_file=""
  _target_link=""
  _internal_path=""
  _destdir=""
}

_global_variables

_target_file="${1}"
_internal_path="${2}"
if [[ -v "DESTDIR" ]]; then
  _destdir="${DESTDIR}"
  if (( 2 < "$#" )); then
    _destdir="${3}"
  fi
elif [[ ! -v "DESTDIR" || \
        "${DESTDIR}" == "" ]]; then
  _destdir=""
  if (( 2 < "$#" )); then
    _destdir="${3}"
  fi
fi
if [[ "${_os}" == "Android" ]]; then
  _destdir="@ANDROID_ROOT@"
fi
_target_link="${_destdir}${_internal_path}"
mkdir \
  -vp \
  "$(dirname \
       "${_target_link}")"
rm \
  -f \
  "${_target_link}"
ln \
  -vs \
  "${_target_file}" \
  "${_target_link}" || \
  true
