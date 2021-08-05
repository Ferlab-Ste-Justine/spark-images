FROM openjdk:8u242-jre

RUN apt-get update && apt-get install -y gettext

WORKDIR /opt

ARG HADHOOP_VERSION=3.2.0
ARG METASTORE_VERSION=3.0.0

ENV HADOOP_VERSION=$HADHOOP_VERSION
ENV METASTORE_VERSION=$METASTORE_VERSION

ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
ENV HIVE_HOME=/opt/apache-hive-metastore-${METASTORE_VERSION}-bin

RUN curl -L https://mirror.dsrg.utoronto.ca/apache/hive/hive-standalone-metastore-${METASTORE_VERSION}/hive-standalone-metastore-${METASTORE_VERSION}-bin.tar.gz | tar zxf - && \
    curl -L https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | tar zxf - && \
    wget https://jdbc.postgresql.org/download/postgresql-42.2.16.jar -O ${HIVE_HOME}/lib/postgresql-jdbc.jar

COPY scripts/entrypoint.sh /entrypoint.sh

RUN groupadd -r hive --gid=1000 && \
    useradd -r -g hive --uid=1000 -d ${HIVE_HOME} hive && \
    chown hive:hive -R ${HIVE_HOME} && \
    chown hive:hive /entrypoint.sh && chmod +x /entrypoint.sh

COPY conf/metastore-site.xml.template ${HIVE_HOME}/conf
RUN chown hive:hive ${HIVE_HOME}/conf/metastore-site.xml.template

USER hive
EXPOSE 9083

ENTRYPOINT ["sh", "-c", "/entrypoint.sh"]