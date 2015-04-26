# git-deps-docker

Docker file for git-deps server and command line

# Start git-deps server

Just execute the <code>run.sh /absolute/path/to/your/git/repo</code>. This script will build and run the docker image
with the git repository under the given location. The server will be reachable on <code>http://localhost:5000</code>

# Use git-deps command line

If you started the git-deps server already, you can log in into the running docker container using:

```
docker exec -t -i git-deps /bin/bash
```

If not, you can start the container without running the server, opening the command line instead:

```
docker run --rm -t -i -p 5000:5000 -v /absolute/path/to/your/git/repo:/src --name git-deps pwb/git-deps /bin/bash
```

# Motivation

As in Ubuntu 14.10 it is not trivial to install git-deps because of the python dependencies (especially
libgit2 >=0.22), I created this Dockerfile, based on ubuntu 15.04, which brings libgit2 0.22 out of
the box.

