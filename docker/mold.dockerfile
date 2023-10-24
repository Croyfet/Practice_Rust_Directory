FROM rust:latest

ARG OS_GID
ARG OS_GROUPNAME
ARG OS_UID
ARG OS_USERNAME

RUN apt-get update && apt-get install -y \
sudo \
vim \
cmake \
wget \
make \
gcc \
g++ \
git \
&& \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

RUN groupadd --force --gid "${OS_GID}" "${OS_GROUPNAME}" && \
useradd -m -s /bin/bash -u ${OS_UID} -g ${OS_GID} ${OS_USERNAME} && \
echo "${OS_USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/${OS_USERNAME}

RUN git clone https://github.com/rui314/mold.git && \
mkdir mold/build && \
cd mold/build && \
git checkout v2.0.0 && \
../install-build-deps.sh && \
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=c++ .. && \
cmake --build . -j $(nproc) && \
cmake --install . && \
cd ../../ && \
rm -rf mold

RUN echo "[target.ARCHITECTURE]" >> /usr/local/cargo/config && \
echo "linker = \"clang\"" >> /usr/local/cargo/config && \
echo "rustflags = [\"-C\", \"link-arg=-fuse-ld=mold\"]" >> /usr/local/cargo/config

USER ${OS_USERNAME}
