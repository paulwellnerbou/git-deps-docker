FROM python:slim-stretch
MAINTAINER Paul Wellner Bou "<paul@wellnerbou.de>"

RUN apt-get update && apt-get install -y git-core nodejs libgit2-24 libgit2-dev build-essential
RUN pip install git-deps

RUN npm install -g browserify
#RUN ln -s /usr/bin/nodejs /usr/bin/node
#RUN cd git-deps/html && npm install && browserify -t coffeeify -d js/git-deps-graph.coffee -o js/bundle.js

RUN mkdir -p /src
VOLUME /src
WORKDIR /src

EXPOSE 5000

CMD ["git", "deps", "--serve", "--bind-ip=0.0.0.0"]
