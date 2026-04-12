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
if (( 2 < "$#" )); then
  _destdir="${3}"
else
  _destdir="${DESTDIR}"
  if [[ "${_os}" == "Android" ]]; then
    _destdir="@ANDROID_ROOT@"
  fi
fi
_target_link="${_destdir}${_internal_path}"
mkdir \
  -vp \
  "$(dirname \
       "${_target_link}")" || \
  true
rm \
  -v \
  -f \
  "${_target_link}" || \
  true
ln \
  -vs \
  "${_target_file}" \
  "${_target_link}" || \
  true
