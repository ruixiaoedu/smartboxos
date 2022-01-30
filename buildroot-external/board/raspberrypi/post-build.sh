#!/bin/sh

set -u
set -e

# Fix overlay presets
"${HOST_DIR}/bin/systemctl" --root="${TARGET_DIR}" enable getty@tty1.service