#!/usr/bin/env bash

mkdir -p work
cd work
wget http://apache.mirror.iweb.ca/spark/spark-3.0.0/spark-3.0.0-bin-hadoop3.2.tgz
tar xf spark-3.0.0-bin-hadoop3.2.tgz
wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.855/aws-java-sdk-bundle-1.11.855.jar -o spark-3.0.0-bin-hadoop3.2/jars/aws-java-sdk-bundle-1.11.855.jar
wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.2.1/hadoop-aws-3.2.1.jar -o spark-3.0.0-bin-hadoop3.2/jars/hadoop-aws-3.2.1.jar

spark-3.0.0-bin-hadoop3.2/bin/docker-image-tool.sh -r ferlab -t 3.0.0 build
