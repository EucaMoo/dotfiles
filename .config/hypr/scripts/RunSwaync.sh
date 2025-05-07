#!/bin/bash

if pgrep -x "swaync" > /dev/null; then
    pkill -x "swaync"
fi

# 启动swaync并放入后台运行
swaync &

# 发送命令打开通知面板
sleep 1
swaync-client -t -sw
