#!/bin/sh

export HADOOP_HOME=/opt/hadoop-3.2.0
export HADOOP_CLASSPATH=${HADOOP_HOME}/share/hadoop/tools/lib/aws-java-sdk-bundle-1.11.375.jar:${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-aws-3.2.0.jar
export JAVA_HOME=/usr/local/openjdk-8

envsubst '${DB_HOST} ${DB} ${DB_USER} ${DB_PASSWORD} ${S3_ACCESS_KEY} ${S3_SECRET_KEY} ${S3_ENDPOINT}' < ${HIVE_HOME}/conf/metastore-site.xml > ${HIVE_HOME}/conf/metastore-site.xml

/opt/apache-hive-metastore-3.0.0-bin/bin/schematool -initSchema -dbType postgres
/opt/apache-hive-metastore-3.0.0-bin/bin/start-metastore
