#!/usr/bin/env bash

export PATH="$PATH:$HOME/bin"

APP_PROMETHEUS="/app/prometheus"

PRERUN_SCRIPT="$APP_PROMETHEUS/prerun.sh"
if [ -e "$PRERUN_SCRIPT" ]; then
  source "$PRERUN_SCRIPT"
fi

if [ -n "$DISABLE_PROMETHEUS" ]; then
  echo "The Prometheus agent has been disabled. Unset the $DISABLE_PROMETHEUS or set missing environment variables."
else
  bash -c "prometheus --log.level=${PROMETHEUS_LOG_LEVEL:=info} --config.file=\"$APP_PROMETHEUS/config.yml\" 2>&1 &"
fi
