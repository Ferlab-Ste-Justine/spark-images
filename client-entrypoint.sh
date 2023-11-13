#!/usr/bin/env bash
set -e

# Run the certificate installation script
/opt/install_ca.sh

# Run the existing setup configuration script
/opt/setup-config.sh;

# Check for SPARK_JAR environment variable
if [ -z "$SPARK_JAR" ]; then
    echo "SPARK_JAR environment variable needs to be defined";
    exit 1;
fi

# Submit the Spark job
if [ ! -z "$SPARK_CLASS" ]; then
    /opt/spark/bin/spark-submit --class $SPARK_CLASS $SPARK_JAR "$@";
else
    /opt/spark/bin/spark-submit $SPARK_JAR "$@";
fi
