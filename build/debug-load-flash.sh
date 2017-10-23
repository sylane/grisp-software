#!/bin/sh

# be more verbose
set -x
# exit on wrong command and undefined variables
set -e -u

# find out own directory
SCRIPTDIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PROJECTDIR="${SCRIPTDIR}/../"

ELFFILE=$1

${SCRIPTDIR}/debug-start-openocd.sh \
	-c "reset" -c "halt" -c "mww 0x400e0c04 0x5a00010b"\
	-c "reset" -c "halt" -c "program \"${ELFFILE}\"" \
	-c "reset" -c "halt" -c "verify_image_checksum \"${ELFFILE}\"" \
	-c "reset" -c "exit"
