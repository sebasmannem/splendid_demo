#!/bin/bash
user=${1}
file=${2}
folder=$( getent passwd "$user" | cut -d: -f6 )

touch "$folder/.bash_alias"
grep -q '.bash_alias' "${file}" || echo ". '${folder}/.bash_alias'" >> "${file}"

grep -qE '^export PAGER=' "${file}" || echo 'export PAGER="/usr/bin/less -Xe"' >> "${file}"

