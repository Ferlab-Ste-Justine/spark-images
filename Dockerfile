ARG SPARK_USER
ARG SPARK_IMAGE_TAG
ARG SPARK_IMAGE_REPO

FROM $SPARK_IMAGE_REPO/spark:$SPARK_IMAGE_TAG

USER 0

COPY install_ca.sh /opt/install_ca.sh
COPY client-entrypoint.sh /opt/
COPY setup-config.sh /opt/
COPY start-history-server.sh /opt/

# Prepare the image for runtime certificate installation
RUN chmod +x /opt/install_ca.sh && \
    mkdir -p /opt/spark/conf /opt/spark-configs/auto /opt/spark-configs-template/auto /etc/certs && \
    touch /opt/spark/conf/spark-defaults.conf && \
    chown -R $SPARK_USER:$SPARK_USER /opt/spark/conf /opt/spark-configs /opt/spark-configs-template /etc/certs && \
    apt-get update && \
    apt-get install -y gettext

COPY auto.conf /opt/spark-configs-template/auto/auto.conf

USER $SPARK_USER
