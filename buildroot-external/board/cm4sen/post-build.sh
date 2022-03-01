#!/bin/sh

set -u
set -e

BSP_INST_HOME_PATH=$(dirname $(realpath $0))

# 复制必要文件
cp $BSP_INST_HOME_PATH/boot-overlay/cmdline.txt ${BINARIES_DIR}/rpi-firmware/
cp $BSP_INST_HOME_PATH/boot-overlay/dt-blob.bin ${BINARIES_DIR}/rpi-firmware/
cp $BSP_INST_HOME_PATH/boot-overlay/overlays/*.dtbo ${BINARIES_DIR}/rpi-firmware/overlays/

# 开启RTC功能
"${HOST_DIR}/bin/systemctl" --root="${TARGET_DIR}" enable rtc.service

# 加载BOOT
install -d -m 0755 ${TARGET_DIR}/boot
echo '/dev/mmcblk0p1 /boot vfat defaults 0 0' >> ${TARGET_DIR}/etc/fstab