ARG SPARK_VERSION=3.5.5

FROM apache/spark:${SPARK_VERSION}-scala2.12-java11-python3-r-ubuntu
ARG SPARK_USER=185
ARG AWS_JAVA_SDK_VERSION=1.12.785
ARG HADOOP_AWS_VERSION=3.3.4
ENV SPARK_USER=$SPARK_USER
ENV AWS_JAVA_SDK_VERSION=$AWS_JAVA_SDK_VERSION
ENV HADOOP_AWS_VERSION=$HADOOP_AWS_VERSION

USER 0

COPY cqgc-prod-es-ca.crt /opt/ca.crt
COPY cqdg-prod-es-ca.crt /opt/ca_cqdg.crt
COPY cqdg-qa-os-ca.crt /opt/ca_cqdg_juno_qa.crt
COPY install_ca.sh /opt/install_ca.sh
COPY client-entrypoint.sh /opt/
COPY setup-config.sh /opt/
COPY start-history-server.sh /opt/

RUN chmod +x /opt/install_ca.sh && \
    /opt/install_ca.sh && \
    rm /opt/install_ca.sh && \
    mkdir -p /opt/spark/conf /opt/spark-configs/auto /opt/spark-configs-template/auto && \
    touch /opt/spark/conf/spark-defaults.conf && \
    chown -R $SPARK_USER:$SPARK_USER /opt/spark/conf /opt/spark-configs /opt/spark-configs-template && \
    apt-get update && \
    apt-get install -y gettext && \
    apt-get install wget -y && \
    wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/$AWS_JAVA_SDK_VERSION/aws-java-sdk-bundle-$AWS_JAVA_SDK_VERSION.jar -O /opt/spark/jars/aws-java-sdk-bundle-$AWS_JAVA_SDK_VERSION.jar && \
    wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.4/hadoop-aws-$HADOOP_AWS_VERSION.jar -O /opt/spark/jars/hadoop-aws-$HADOOP_AWS_VERSION.jar

COPY auto.conf /opt/spark-configs-template/auto/auto.conf

USER $SPARK_USER
