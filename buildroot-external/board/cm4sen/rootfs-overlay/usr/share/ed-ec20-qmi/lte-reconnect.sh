#!/bin/bash
#
# Created by ahnniu@gmail.com in Oct 2020
#

BSP_HOME_PATH=$(dirname $(realpath $0))
LTE_RST_PIN=10
LOG_PATH=/var/log/ed-ec20-qmi
LOGFILE=$LOG_PATH/quectel-CM.log


function do_lte_init_rst_pin() {
    raspi-gpio set $LTE_RST_PIN pd
    raspi-gpio set $LTE_RST_PIN op dl
}

function do_lte_rst() {
    raspi-gpio set $LTE_RST_PIN dh
    sleep 5
    raspi-gpio set $LTE_RST_PIN dl
    # it takes a while to load the device after reset
    sleep 10

    until [ -e /sys/class/net/wwan0 ]
    do
        sleep 1
    done
}

function do_connect() {
    printf "Kill all quectel-CM ...\n"
    killall -q quectel-CM

    printf "Reset lte module ...\n"
    do_lte_rst

    printf "Try to connect ...\n"
    $BSP_HOME_PATH/quectel-CM -4 -f $LOGFILE &
}

mkdir -p $LOG_PATH

do_lte_init_rst_pin

do_connect

while true; do

    ping -I wwan0 -c 1 -s 0 223.5.5.5

    if [ $? -eq 0 ]; then
        echo "Connection up, reconnect not required..."
    else
        # 10秒后重试，防止偶发性网络抖动导致4G断开
        sleep 10
        ping -I wwan0 -c 1 -s 0 223.5.5.5

        if [ $? -eq 0 ]; then
            echo "Connection up, reconnect not required..."
        else
            echo "Connection down, reconnecting..."
            do_connect
        fi
    fi

    sleep 40
done
