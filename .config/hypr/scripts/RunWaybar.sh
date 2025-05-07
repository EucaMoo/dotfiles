#!/bin/bash

config_file="$HOME/.config/waybar/config"
style_file="$HOME/.config/waybar/style.css"
error_messages=() # 存储错误信息的数组

# 检查配置文件
[ ! -f "$config_file" ] && error_messages+=("Waybar 配置文件不存在于 $config_file")

# 检查样式文件
[ ! -f "$style_file" ] && error_messages+=("Waybar 样式文件不存在于 $style_file")

# 如果有错误则统一报错
if [ ${#error_messages[@]} -gt 0 ]; then
    echo "发现以下错误：" >&2
    printf '  %s\n' "${error_messages[@]}" >&2
    exit 1
fi

# 后续正常流程
if pgrep -x "waybar" >/dev/null; then
    pkill -x "waybar"
    sleep 0.5
fi

waybar -c "$config_file" -s "$style_file" &
