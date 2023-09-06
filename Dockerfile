ARG SPARK_USER
ARG SPARK_IMAGE_TAG
ARG SPARK_IMAGE_REPO

# Base image
FROM $SPARK_IMAGE_REPO/spark:$SPARK_IMAGE_TAG

USER 0

#Temporary directives to accomodate temporary minio internal CA
COPY cqgc-prod-es-ca.crt /opt/ca.crt \
     cqdg-prod-es-ca.crt /opt/ca_cqdg.crt \
     cqdg-qa-os-ca.crt /opt/ca_cqdg_juno_qa.crt \
     install_ca.sh /opt/install_ca.sh \
     client-entrypoint.sh /opt/ \
     setup-config.sh /opt/ \
     start-history-server.sh /opt/

RUN chmod +x /opt/install_ca.sh && \
    /opt/install_ca.sh && \
    rm /opt/install_ca.sh && \
    mkdir -p /opt/spark/conf /opt/spark-configs/auto /opt/spark-configs-template/auto && \
    touch /opt/spark/conf/spark-defaults.conf && \
    chown -R $SPARK_USER:$SPARK_USER /opt/spark/conf /opt/spark-configs /opt/spark-configs-template && \
    apt-get update && \
    apt-get install -y gettext


COPY auto.conf /opt/spark-configs-template/auto/auto.conf

USER $SPARK_USER