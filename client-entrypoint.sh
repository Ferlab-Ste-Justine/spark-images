#!/usr/bin/env bash

if [ -z "$SPARK_CLIENT_POD_NAME" ]; then
    echo "SPARK_CLIENT_POD_NAME environment variable needs to be defined";
    exit 1;
fi

if [ ! -f "/opt/spark/conf/spark-defaults.conf" ]; then
    echo "/opt/spark/conf/spark-defaults.conf does not exist";
    exit 1;
fi

if [ -z "$SPARK_JAR" ]; then
    echo "SPARK_JAR environment variable needs to be defined";
    exit 1;
fi

envsubst '${SPARK_CLIENT_POD_NAME}' < /opt/spark-configs/auto/auto.conf > /opt/spark-configs/auto/auto.conf

for CONFIG_FILE in /opt/spark-configs/*/*; do
    cat $CONFIG_FILE >> /opt/spark/conf/spark-defaults.conf;
done

if [ ! -z "$SPARK_CLASS" ]; then
    /opt/spark/bin/spark-submit --class $SPARK_CLASS $SPARK_JAR;
else
    /opt/spark/bin/spark-submit $SPARK_JAR;
fi