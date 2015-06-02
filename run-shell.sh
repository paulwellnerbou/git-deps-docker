#!/bin/sh

set -u
set -e

echo "Building git-deps docker file for repository $1..."

docker build -t pwb/git-deps .
docker run --rm -t -i -p 5000:5000 -v $1:/src --name git-deps pwb/git-deps /bin/bash

