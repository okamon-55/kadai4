#!/bin/bash

# 引数の数を確認
if [ $# -ne 2 ]; then
  echo "エラー: 引数は2つの自然数を指定してください。" >&2
  exit 1
fi

# 自然数（正の整数）かを確認（0は含めない）
for arg in "$1" "$2"; do
  if ! [[ "$arg" =~ ^[1-9][0-9]*$ ]]; then
    echo "エラー: '$arg' は自然数（1以上の整数）ではありません。" >&2
    exit 1
  fi
done

# 変数に代入
a=$1
b=$2

# ユークリッドの互除法でGCDを計算
while [ "$b" -ne 0 ]; do
  temp=$b
  b=$((a % b))
  a=$temp
done

echo "最大公約数: $a"

