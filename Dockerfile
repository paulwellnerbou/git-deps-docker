FROM ubuntu:15.04
MAINTAINER Paul Wellner Bou "<paul@wellnerbou.de>"

RUN apt-get update && apt-get install -y \
        vim less git-core python-dev python-pip libgit2-dev gawk libffi-dev npm net-tools
RUN pip install pygit2
RUN pip install flask

# Cloning git-deps and resetting to a known working revision, compatible with this Dockerfile
RUN git clone https://github.com/aspiers/git-deps.git && cd git-deps && git reset --hard 3d8f8952cd127dc1a33c910a833de328d657a7cb
RUN ln -s $PWD/git-deps/git-deps /usr/bin/git-deps

RUN npm install -g browserify
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN cd git-deps/html && npm install && browserify -t coffeeify -d js/git-deps-graph.coffee -o js/bundle.js

RUN mkdir -p /src
VOLUME /src
WORKDIR /src

EXPOSE 5000

CMD ["git", "deps", "--serve", "--bind-ip=0.0.0.0"]

