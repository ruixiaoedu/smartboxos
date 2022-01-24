#!/bin/bash
set -e

COMMAND="${ARGS:-bash}"

[ ! -z $(docker images -q smartboxos:build) ] || sudo docker build -t smartboxos:build .

sudo docker run -it --rm --privileged \
  -v "$(pwd):/build" \
  smartboxos:build ${COMMAND}