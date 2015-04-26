#!/bin/sh
docker build -t pwb/git-deps .
docker run --rm -t -i -p 5000:5000 -v $1:/src --name git-deps pwb/git-deps

