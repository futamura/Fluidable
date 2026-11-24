#!/usr/bin/env bash
# Runs a command, retrying with a growing delay when it fails.
# Usage: retry.sh <attempts> <command> [args...]
set -uo pipefail

attempts="$1"
shift

for ((attempt = 1; attempt <= attempts; attempt++)); do
  "$@" && exit 0
  status=$?
  if ((attempt < attempts)); then
    delay=$((attempt * 30))
    echo "::warning::'$*' failed with status $status (attempt $attempt/$attempts); retrying in ${delay}s"
    sleep "$delay"
  fi
done

echo "::error::'$*' failed after $attempts attempts"
exit "$status"
