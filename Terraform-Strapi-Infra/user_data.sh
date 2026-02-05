#!/bin/bash
apt update -y
apt install docker.io -y
systemctl enable docker
systemctl start docker
docker pull strapi/strapi
docker run -d -p 1337:1337 strapi/strapi
