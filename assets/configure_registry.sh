#!/usr/bin/env bash

set -e

echo -n | openssl s_client -connect registry.stf.jus.br:443 -showcerts 2>/dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > ca.crt

sudo mkdir -p /etc/docker/certs.d/registry.stf.jus.br
sudo cp ./ca.crt /etc/docker/certs.d/registry.stf.jus.br/ca.crt
sudo ls /etc/docker/certs.d/registry.stf.jus.br/
sudo service docker restart
