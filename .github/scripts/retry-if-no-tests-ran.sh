#!/usr/bin/env bash
# Runs an xcodebuild test command and runs it once more when it fails before any
# test case starts, for example when the test runner or CoreSimulator crashes.
# A failure after a test case has started is reported as is.
# Usage: retry-if-no-tests-ran.sh <result-bundle-path> <command> [args...]
# The first attempt's result bundle is kept at <result-bundle-path>.attempt1.
# Set SIMULATOR_UDID to wait for that simulator to boot again before the retry.
set -uo pipefail

result_bundle="$1"
shift
log="$(mktemp)"

for attempt in 1 2; do
  "$@" 2>&1 | tee "$log"
  status=${PIPESTATUS[0]}
  if ((status == 0)); then
    exit 0
  fi
  if grep -q "^Test Case '.*' started" "$log"; then
    exit "$status"
  fi
  if ((attempt == 1)); then
    echo "::warning::'$1' failed with status $status before any test case started; retrying once"
    if [ -e "$result_bundle" ]; then
      mv "$result_bundle" "$result_bundle.attempt1"
    fi
    if [ -n "${SIMULATOR_UDID:-}" ]; then
      xcrun simctl bootstatus "$SIMULATOR_UDID" -b
    fi
  fi
done

echo "::error::'$1' failed with status $status before any test case started, twice"
exit "$status"
