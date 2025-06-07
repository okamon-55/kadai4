#!/bin/bash

# テスト対象のスクリプト
SCRIPT="./gcd.sh"

# 総テスト数・成功数カウント用
total=0
passed=0

# テスト実行関数
run_test() {
  local desc="$1"
  local arg1="$2"
  local arg2="$3"
  local expected="$4"

  ((total++))
  output=$($SCRIPT "$arg1" "$arg2" 2>&1)
  
  if [[ "$output" == *"$expected"* ]]; then
    echo "[PASS] $desc"
    ((passed++))
  else
    echo "[FAIL] $desc"
    echo "  expected: $expected"
    echo "  got:      $output"
  fi
}

# ==== 正常系テスト ====
run_test "GCD of 36 and 24" 36 24 "最大公約数: 12"
run_test "GCD of 10 and 5" 10 5 "最大公約数: 5"
run_test "GCD of 7 and 3" 7 3 "最大公約数: 1"

# ==== 異常系テスト ====
run_test "Only one argument" 10 "" "エラー: 引数は2つの自然数を指定してください。"
run_test "Non-numeric argument" 10 abc "エラー: 'abc' は自然数（1以上の整数）ではありません。"
run_test "Zero is invalid" 0 5 "エラー: '0' は自然数（1以上の整数）ではありません。"
run_test "Negative number is invalid" -3 6 "エラー: '-3' は自然数（1以上の整数）ではありません。"
run_test "Decimal is invalid" 4.5 3 "エラー: '4.5' は自然数（1以上の整数）ではありません。"

# ==== テスト結果表示 ====
echo ""
echo "テスト結果: $passed / $total テスト成功"

# 終了ステータス
if [ "$passed" -eq "$total" ]; then
  exit 0
else
  exit 1
fi

