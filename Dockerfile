FROM apache/spark:v3.3.2
USER 0
RUN apt-get update && \
    apt-get install wget -y && \
    wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.1026/aws-java-sdk-bundle-1.11.1026.jar -O /opt/spark/jars/aws-java-sdk-bundle-1.11.1026.jar && \
    wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.2/hadoop-aws-3.3.2.jar -O /opt/spark/jars/hadoop-aws-3.3.2.jar

USER 185
