FROM apache/zeppelin:0.9.0

ADD https://storage.googleapis.com/kubernetes-release/release/v1.19.3/bin/linux/amd64/kubectl /usr/bin/kubectl

USER 0

RUN chmod +x /usr/bin/kubectl
RUN echo "zeppelin:x:1000:0:anonymous uid:/zeppelin:/bin/false" >> /etc/passwd

USER 1000