#!/usr/bin/env bash

set -e

sudo mkdir -p /etc/docker/certs.d/registry.stf.jus.br
sudo cp ./shared/certificates/ca.crt /etc/docker/certs.d/registry.stf.jus.br/ca.crt
sudo ls /etc/docker/certs.d/registry.stf.jus.br/
sudo service docker restart
