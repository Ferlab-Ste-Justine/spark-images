FROM apache/zeppelin:0.9.0

ADD https://storage.googleapis.com/kubernetes-release/release/v1.19.3/bin/linux/amd64/kubectl /usr/bin/kubectl

USER 0

RUN chmod +x /usr/bin/kubectl
RUN useradd --uid=1000 --home-dir=/zeppelin --user-group zeppelin

USER 1000