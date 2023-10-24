FROM rust:latest

ARG OS_GID
ARG OS_GROUPNAME
ARG OS_UID
ARG OS_USERNAME

RUN apt-get update && apt-get install -y \
sudo \
vim \
&& \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

RUN groupadd --force --gid "${OS_GID}" "${OS_GROUPNAME}" && \
useradd -m -s /bin/bash -u ${OS_UID} -g ${OS_GID} ${OS_USERNAME} && \
echo "${OS_USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/${OS_USERNAME}

USER ${OS_USERNAME}
