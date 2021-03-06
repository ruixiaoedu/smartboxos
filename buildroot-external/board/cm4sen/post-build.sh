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

# 开启4G连接功能
"${HOST_DIR}/bin/systemctl" --root="${TARGET_DIR}" enable lte-reconnect.service

# 加载重置文件系统大小
"${HOST_DIR}/bin/systemctl" --root="${TARGET_DIR}" enable resize2fs_once

# 配置文件读写权限，否则无法适配网络
chmod 600 ${TARGET_DIR}/etc/NetworkManager/system-connections/eth0.nmconnection

# 加载BOOT
install -d -m 0755 ${TARGET_DIR}/boot
echo '/dev/mmcblk0p1 /boot vfat defaults 0 0' >> ${TARGET_DIR}/etc/fstab