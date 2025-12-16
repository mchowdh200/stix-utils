#!/bin/bash

set -e

docker build --platform linux/amd64 -t excord-lr .
docker tag excord-lr mchowdh200/excord-lr:latest
docker push mchowdh200/excord-lr
