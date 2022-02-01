#!/bin/sh

set -u
set -e

# 开启getty登录支持
# "${HOST_DIR}/bin/systemctl" --root="${TARGET_DIR}" enable console-getty.service getty@tty1.service