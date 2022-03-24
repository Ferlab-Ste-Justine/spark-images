#!/usr/bin/env bash
set -e

#Temporary script to accomodate temporary minio internal CA

if [ -s /opt/ca.crt ]; then

    cp /opt/ca.crt /usr/local/share/ca-certificates/ca.crt
    update-ca-certificates

    openssl x509 -in /opt/ca.crt -inform pem -out /opt/ca.der -outform der
    keytool -noprompt -importcert -trustcacerts -cacerts -alias cqgc-ingress -storepass changeit -file /opt/ca.der

    rm /opt/ca.der
fi

rm /opt/ca.crt