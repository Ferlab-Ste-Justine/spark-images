ARG SPARK_USER
ARG SPARK_VERSION
FROM chusj/spark:$SPARK_VERSION

USER 0

RUN mkdir -p /opt/spark/conf && touch /opt/spark/conf/spark-defaults.conf && \
    touch /opt/spark/conf/spark-defaults.conf && \
    chown $SPARK_USER:$SPARK_USER /opt/spark/conf/spark-defaults.conf

USER $SPARK_USER

COPY client-entrypoint.sh /opt/client-entrypoint.sh