#!/usr/bin/env bash
# random.sh — print a random integer N such that a <= N <= b (both inclusive).
# Usage: ./random.sh <a> <b>
set -euo pipefail

usage() {
  printf 'Usage: %s <a> <b>\n' "$(basename "$0")" >&2
  printf '  Prints a random integer N with a <= N <= b (inclusive).\n' >&2
}

if [ "$#" -ne 2 ]; then
  usage
  exit 2
fi

a=$1
b=$2

for v in a b; do
  val=${!v}
  if ! [[ "$val" =~ ^-?[0-9]+$ ]]; then
    printf 'Error: %s must be an integer, got %q\n' "$v" "$val" >&2
    usage
    exit 2
  fi
done

if [ "$a" -gt "$b" ]; then
  printf 'Error: a (%s) must be <= b (%s)\n' "$a" "$b" >&2
  exit 2
fi

awk -v a="$a" -v b="$b" -v seed="$RANDOM$RANDOM$$" \
  'BEGIN { srand(seed); print int(a + rand() * (b - a + 1)) }'
