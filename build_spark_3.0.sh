#!/usr/bin/env bash

mkdir -p work
cd work
wget http://apache.mirror.iweb.ca/spark/spark-3.0.0/spark-3.0.0-bin-hadoop3.2.tgz
tar xf spark-3.0.0-bin-hadoop3.2.tgz
spark-3.0.0-bin-hadoop3.2/bin/docker-image-tool.sh -r ferlab -t 3.0.0 build
