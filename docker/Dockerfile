# LaTeX image which also maps the local user, so that all files created are not owned by root.
#
# To build:
#   docker build -t texlive .
# To run:
#   docker run -it --rm -e "USER=$(id -un)" -e "USER_ID=$(id -u)" -e "GROUP_ID=$(id -g)" \
#       -v $HOME:$HOME -v $(pwd):/opt/workdir texlive pdflatex main
#
FROM harshjv/texlive-2015
LABEL maintainer "jzaremba@gmail.com"

RUN apt-get update -qq \
    && apt-get install -qqy sudo \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

ENV GOSU_VERSION 1.10
RUN set -x \
    && apt-get update && apt-get install -y --no-install-recommends ca-certificates wget && rm -rf /var/lib/apt/lists/* \
    && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    && apt-get purge -y --auto-remove ca-certificates wget

# Intended to volume map in the current working directory to /opt/workdir
RUN mkdir /opt/workdir
WORKDIR /opt/workdir

ENV TZ=US/Eastern

# The entrypoint.sh script will run every time a container is created,
# so keep it simple.
# It maps the local user into the docker container.
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["bash"]

