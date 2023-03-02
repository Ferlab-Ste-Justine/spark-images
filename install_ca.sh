#!/usr/bin/env bash
set -e

#Temporary script to accomodate temporary minio internal CA

if [ -s /opt/ca.crt ]; then

    cp /opt/ca.crt /usr/local/share/ca-certificates/ca.crt
    update-ca-certificates

    openssl x509 -in /opt/ca.crt -inform pem -out /opt/ca.der -outform der
    keytool -noprompt -importcert -trustcacerts -cacerts -alias cqgc-es -storepass changeit -file /opt/ca.der

    rm /opt/ca.der
fi

if [ -s /opt/ca_cqdg.crt ]; then

    cp /opt/ca_cqdg.crt /usr/local/share/ca-certificates/ca_cqdg.crt
    update-ca-certificates

    openssl x509 -in /opt/ca_cqdg.crt -inform pem -out /opt/ca_cqdg.crt -outform der
    keytool -noprompt -importcert -trustcacerts -cacerts -alias cqdg-es -storepass changeit -file /opt/ca_cqdg.der

    rm /opt/ca_cqdg.der
fi

rm /opt/ca.crt
rm /opt/ca_cqdg.crt
