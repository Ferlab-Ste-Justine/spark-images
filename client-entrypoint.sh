#!/usr/bin/env bash

./setup-config.sh;

if [ -z "$SPARK_JAR" ]; then
    echo "SPARK_JAR environment variable needs to be defined";
    exit 1;
fi

if [ ! -z "$SPARK_CLASS" ]; then
    /opt/spark/bin/spark-submit --class $SPARK_CLASS $SPARK_JAR "$@";
else
    /opt/spark/bin/spark-submit $SPARK_JAR "$@";
fi