FROM ubuntu:15.04
MAINTAINER Paul Wellner Bou "<paul@wellnerbou.de>"

RUN apt-get update && apt-get install -y \
        vim less git-core python-dev python-pip libgit2-dev gawk libffi-dev npm net-tools
RUN pip install pygit2
RUN pip install flask

RUN git clone https://github.com/aspiers/git-deps.git
RUN ln -s $PWD/git-deps/git-deps /usr/bin/git-deps

RUN npm install -g browserify
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN cd git-deps/html && npm install && browserify -t coffeeify -d js/git-deps-graph.coffee -o js/bundle.js
RUN ln -s /git-deps/html/node_modules/webcola/WebCola/cola.min.js /git-deps/html/node_modules/webcola/WebCola/cola.v3.min.js
RUN sed -i "s/port=options.port/host='0.0.0.0',port=options.port/" /git-deps/git-deps

RUN mkdir -p /src
VOLUME /src
WORKDIR /src

EXPOSE 5000

CMD ["git", "deps", "--serve"]

