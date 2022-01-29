#!/bin/sh

set -u
set -e

# 不使用Busybox启动无效
# Add a console on tty1
# if [ -e ${TARGET_DIR}/etc/inittab ]; then
#     grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
#         sed -i '/GENERIC_SERIAL/a\
# tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
# fi

# Fix overlay presets
"${HOST_DIR}/bin/systemctl" --root="${TARGET_DIR}" preset-all