FROM ubuntu:15.04
MAINTAINER Paul Wellner Bou "<paul@wellnerbou.de>"

RUN apt-get update && apt-get install -y \
        vim less git-core python-dev python-pip libgit2-dev gawk libffi-dev npm net-tools
RUN pip install pygit2
RUN pip install flask

ENV DATE 2015-06-02

# Cloning git-deps and resetting to a known working revision, compatible with this Dockerfile
# This step might be cached, so use --no-cache building the image or change the date environment variable to now
RUN git clone https://github.com/aspiers/git-deps.git

# Nailing git-deps down to a known working revision if you want to be sure
# RUN cd git-deps && git reset --hard bfcfc1663a7cb4eb8110b4fc39a150724f4b22ba

RUN ln -s $PWD/git-deps/git-deps /usr/bin/git-deps

RUN npm install -g browserify
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN cd git-deps/html && npm install && browserify -t coffeeify -d js/git-deps-graph.coffee -o js/bundle.js

RUN mkdir -p /src
VOLUME /src
WORKDIR /src

EXPOSE 5000

CMD ["git", "deps", "--serve", "--bind-ip=0.0.0.0"]

