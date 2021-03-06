#!/usr/bin/env bash
set -e

export SPARK_VERSION=${SPARK_VERSION:-3.0.1}
export SPARK_IMAGE_TAG=${SPARK_IMAGE_TAG:-$SPARK_VERSION}

if [ ! -d "./work/spark-${SPARK_VERSION}-bin-hadoop3.2" ]; then
  mkdir -p work
  (
      cd work;
      wget http://apache.mirror.iweb.ca/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.2.tgz;
      tar xf spark-${SPARK_VERSION}-bin-hadoop3.2.tgz;
      wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.375/aws-java-sdk-bundle-1.11.375.jar -O spark-${SPARK_VERSION}-bin-hadoop3.2/jars/aws-java-sdk-bundle-1.11.375.jar;
      wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.2.0/hadoop-aws-3.2.0.jar -O spark-${SPARK_VERSION}-bin-hadoop3.2/jars/hadoop-aws-3.2.0.jar;
  )
fi

(
    cd work;
    spark-${SPARK_VERSION}-bin-hadoop3.2/bin/docker-image-tool.sh -r ferlabcrsj -t ${SPARK_IMAGE_TAG} build;
)

docker build --build-arg "SPARK_USER=185" --build-arg "SPARK_IMAGE_TAG=$SPARK_IMAGE_TAG" --build-arg "SPARK_IMAGE_REPO=ferlabcrsj" -t ferlabcrsj/spark:$SPARK_IMAGE_TAG .;
