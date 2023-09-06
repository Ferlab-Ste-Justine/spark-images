ARG SPARK_USER
ARG SPARK_IMAGE_TAG
ARG SPARK_IMAGE_REPO
FROM $SPARK_IMAGE_REPO/spark:$SPARK_IMAGE_TAG

USER 0

#Temporary directives to accomodate temporary minio internal CA
COPY cqgc-prod-es-ca.crt /opt/ca.crt
COPY cqdg-prod-es-ca.crt /opt/ca_cqdg.crt
COPY cqdg-qa-os-ca.crt /opt/ca_cqdg_juno_qa.crt
COPY install_ca.sh /opt/install_ca.sh
RUN chmod +x /opt/install_ca.sh && /opt/install_ca.sh && rm /opt/install_ca.sh

RUN mkdir -p /opt/spark/conf && touch /opt/spark/conf/spark-defaults.conf && \
    touch /opt/spark/conf/spark-defaults.conf && \
    chown $SPARK_USER:$SPARK_USER /opt/spark/conf/spark-defaults.conf

RUN mkdir -p /opt/spark-configs/auto /opt/spark-configs-template/auto
COPY auto.conf /opt/spark-configs-template/auto/auto.conf
RUN chown -R $SPARK_USER:$SPARK_USER /opt/spark-configs /opt/spark-configs-template

RUN apt-get update && apt-get install -y gettext

USER $SPARK_USER

COPY client-entrypoint.sh setup-config.sh start-history-server.sh /opt/
