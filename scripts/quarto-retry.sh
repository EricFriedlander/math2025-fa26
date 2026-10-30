#!/usr/bin/env bash
# Wrapper around the quarto CLI for Positron's "quarto.path" setting.
#
# Positron's Quarto language server runs short-lived quarto processes that create and
# delete .quarto/quarto-session-temp* folders. If a command (like a preview) starts at
# the same moment, its project scan can stat a folder that was just deleted and fail with
# "NotFound: ... quarto-session-temp...". That failure is transient, so retry a few times.

QUARTO_REAL=/usr/local/bin/quarto

for attempt in 1 2 3 4 5; do
  errfile=$(mktemp)
  "$QUARTO_REAL" "$@" 2> >(tee "$errfile" >&2)
  status=$?
  sleep 0.3  # let tee finish writing before we read the file
  if [ "$status" -ne 0 ] && grep -q "quarto-session-temp" "$errfile"; then
    rm -f "$errfile"
    sleep 1
    continue
  fi
  rm -f "$errfile"
  exit "$status"
done
exit "$status"
