# git-deps-docker

Docker file for https://github.com/aspiers/git-deps server and command line

# Start git-deps server

Just execute the `./run.sh /absolute/path/to/your/git/repo`. This script will build and run the docker image
with the git repository under the given location. The server will be reachable on http://localhost:5000

As a reference, there is a `docker-compose.yml` included which opens `git-deps` for this repository. So a simple

```
docker-compose up
```

will start the container and the git-deps server under http://localhost:5000.

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

As in Ubuntu 14.10 it was not trivial to install git-deps because of the python dependencies (especially
libgit2 >=0.22), I created this Dockerfile, based on ubuntu 15.04, which brings libgit2 0.22 out of
the box.

Now the versions and the dependency problems changed, but still it is not always eas to get it running on your system, so
consider this as a running reference setup.
