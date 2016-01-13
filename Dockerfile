FROM sickp/alpine-sshd:latest

RUN \
  # remove the root password, we'll use key pairs
  passwd -d root && \
  # install curl
  apk add --update curl && \
  # install the latest docker client
  curl -o /usr/local/bin/docker -L \
    "https://get.docker.com/builds/Linux/x86_64/docker-latest" && \
  chmod +x /usr/local/bin/docker && \
  # clean up
  apk del curl && \
  rm -rf /var/cache/apk/*

COPY start /

ENTRYPOINT ["/start"]
