#!/bin/bash
docker buildx build --push \
  --tag rjst/capnpc:latest \
  --platform linux/amd64,linux/arm64 .


docker buildx build --push \
  --tag rjst/capnpc:capnp-v0.10.3-capnp-java-v0.1.15 \
  --platform linux/amd64,linux/arm64 .
