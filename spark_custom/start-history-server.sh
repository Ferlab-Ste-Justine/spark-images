#!/usr/bin/env bash
set -e

/opt/setup-config.sh;

export SPARK_NO_DAEMONIZE=true

/opt/spark/sbin/start-history-server.sh