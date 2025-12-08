FROM apache/spark:3.5.5
USER 0
RUN apt-get update && \
    apt-get install wget -y && \
    wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.785/aws-java-sdk-bundle-1.12.785.jar -O /opt/spark/jars/aws-java-sdk-bundle-1.12.785.jar && \
    wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.4/hadoop-aws-3.3.4.jar -O /opt/spark/jars/hadoop-aws-3.3.4.jar

USER 185
