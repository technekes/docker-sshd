# SSHD

This image writes out the environment variable `PUBLIC_KEY` into `/root/.ssh/authorized_keys` allowing for key based authentication.

## Usage

The following will start up an SSH server exposed on port `2222` with the variable `$PUBLIC_KEY` used as the public key (assumes a public key at `~/.ssh/id_rsa.pub`. In addition we are bind mounting the Docker socket so that we can access the Docker contaners running on the host. The use case here is running an SSH container on a cluster node (AWS ECS for example) and iterecting with running containers.

```sh
export PUBLIC_KEY="$(cat ~/.ssh/id_rsa.pub)"

docker run \
  -d \
  -p "2222:22" \
  -e "PUBLIC_KEY=${PUBLIC_KEY}" \
  --name=sshd \
  -v /var/run/docker.sock:/var/run/docker.sock \
  technekes/ssh
```

Now connect to the server (assume running locall via `docker-machine` and a private key at `~/.ssh/id_rsa`).

```sh
ssh \
  -i ~/.ssh/id_rsa \
  -p 2222 \
 "root@$(docker-machine ip dev)"
```
