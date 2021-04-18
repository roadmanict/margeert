#!/bin/bash

cd "$(dirname "$BASH_SOURCE")"

git submodule init
git submodule update --remote --merge

export HUGO_VERSION=0.82.0
export HUGO_LOCATION=./bin/${HUGO_VERSION}

if [[ ! -d ${HUGO_LOCATION} ]]
then
  mkdir -p ${HUGO_LOCATION}
  curl -L -o ${HUGO_LOCATION}/hugo_extended.tar.gz https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_macOS-64bit.tar.gz
  tar -xf ${HUGO_LOCATION}/hugo_extended.tar.gz -C ${HUGO_LOCATION}
fi

${HUGO_LOCATION}/hugo server