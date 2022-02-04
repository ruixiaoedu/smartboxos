#!/bin/sh

set -u
set -e

BOARD_DIR="$(dirname $0)"

BSP_INST_HOME_PATH=$(dirname $(realpath $0))

TARGET_ROOTFS_PATH=${BINARIES_DIR}

BLACKLIST=${TARGET_DIR}/etc/modprobe.d/raspi-blacklist.conf
BLACKLIST_DIR=$(dirname $BLACKLIST)
MODULES_FILE=${TARGET_DIR}/etc/modules

module_load() {
    local name="$1"

    # 注释
    sed $BLACKLIST -i -e "s/^\(blacklist[[:space:]]*$name\)/#\1/"
    # 取消注释
    sed $MODULES_FILE -i -e "s/^#[[:space:]]*\($name\)/\1/"

    if ! grep -q "^$name" $MODULES_FILE; then
        printf "$name\n" >> $MODULES_FILE
    fi
}

module_load_i2c() {
    # 注释
    sed $BLACKLIST -i -e "s/^\(blacklist[[:space:]]*i2c[-_]bcm2708\)/#\1/"
    # 取消注释
    sed $MODULES_FILE -i -e "s/^#[[:space:]]*\(i2c[-_]dev\)/\1/"

    if ! grep -q "^i2c[-_]dev" $MODULES_FILE; then
        printf "i2c-dev\n" >> $MODULES_FILE
    fi
}

module_load_spi() {
    sed $BLACKLIST -i -e "s/^\(blacklist[[:space:]]*spi[-_]bcm2708\)/#\1/"
}


do_modules() {
    if ! [ -e $BLACKLIST ]; then
        mkdir -p $BLACKLIST_DIR
        touch $BLACKLIST
    fi

    module_load_i2c
    module_load_spi
    module_load mcp251x
}

# 复制必要文件
do_install() {
    cp $BSP_INST_HOME_PATH/boot-overlay/dt-blob.bin ${BINARIES_DIR}/rpi-firmware/
    cp $BSP_INST_HOME_PATH/boot-overlay/overlays/*.dtbo ${BINARIES_DIR}/rpi-firmware/overlays/
}


do_install
do_modules


# 开启RTC功能
"${HOST_DIR}/bin/systemctl" --root="${TARGET_DIR}" enable rtc.servic
