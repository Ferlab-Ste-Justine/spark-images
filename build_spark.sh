#!/usr/bin/env bash
set -e

export SPARK_VERSION=${SPARK_VERSION:-3.2.1}
export HADOOP_VERSION=${HADOOP_VERSION:-3.3.3}
export SPARK_IMAGE_TAG=${SPARK_IMAGE_TAG:-$SPARK_VERSION}
export MAVEN_OPTS=" -Xms12g -Xmx12g -Xss128M -XX:MaxMetaspaceSize=4g -XX:MaxPermSize=2G"
export JVM_OPTS="-Xms8g\n-Xmx8g\n-XX:ReservedCodeCacheSize=2g"

aws_bundle_version="1.12.235"
artifact="spark-${SPARK_VERSION}-bin-hadoop-${HADOOP_VERSION}"

echo " ########## Building ${artifact} ..."

if [ ! -d ${artifact} ]; then

  echo " ########## Downloading spark ..."
  git clone https://github.com/apache/spark.git spark_clone
  cd spark_clone
  git checkout "tags/v${SPARK_VERSION}" -b "v${SPARK_VERSION}"

  echo " ########## Building spark ..."
  echo ${JVM_OPTS} >> .jvmopts
  ./dev/make-distribution.sh --name hadoop-${HADOOP_VERSION} --pip -Psparkr -Phive -Phive-thriftserver -Pkubernetes -Dhadoop.version="${HADOOP_VERSION}" -DskipTests
  cd ..
  mv spark_clone/dist ${artifact}

  wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/${aws_bundle_version}/aws-java-sdk-bundle-${aws_bundle_version}.jar -O ${artifact}/jars/aws-java-sdk-bundle-${aws_bundle_version}.jar;
  wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/${HADOOP_VERSION}/hadoop-aws-${HADOOP_VERSION}.jar -O ${artifact}/jars/hadoop-aws-${HADOOP_VERSION}.jar;

  tar -cvzf ${artifact}.tgz ${artifact}
fi

./${artifact}/bin/docker-image-tool.sh -r ferlabcrsj -t ${SPARK_IMAGE_TAG} build;

docker build --build-arg "SPARK_USER=185" --build-arg "SPARK_IMAGE_TAG=$SPARK_IMAGE_TAG" --build-arg "SPARK_IMAGE_REPO=ferlabcrsj" -t ferlabcrsj/spark:$SPARK_IMAGE_TAG .;
