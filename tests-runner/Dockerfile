FROM buildpack-deps:bookworm

WORKDIR /tests-runner

RUN apt-get update && apt-get install -y protobuf-compiler  gcc-aarch64-linux-gnu gcc-arm-linux-gnueabihf gcc-x86-64-linux-gnu curl bison npm python3-pip bash bsdmainutils ca-certificates curl gnupg
RUN install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN chmod a+r /etc/apt/keyrings/docker.gpg
RUN echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update
RUN apt-get install -y docker-ce docker-ce-cli containerd.io

# required for gvm
SHELL ["/bin/bash", "-c"]
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o rustup-init.sh
RUN chmod +x rustup-init.sh
RUN ./rustup-init.sh -y -c rustfmt -c clippy --default-toolchain nightly-2023-04-19
ENV PATH="$PATH:/root/.cargo/bin"
RUN rustup target add --toolchain nightly-2023-04-19 aarch64-unknown-linux-gnu,x86_64-unknown-linux-gnu,x86_64-apple-darwin,aarch64-apple-darwin

RUN curl -sSL https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3 get-pip.py
RUN CARGO_NET_GIT_FETCH_WITH_CLI=true python3 -m pip install cargo-zigbuild

RUN npm install express

RUN pip3 install --break-system-packages flask fastapi uvicorn "httptools>=0.5.0" "uvloop>=0.14.0,!=0.15.0,!=0.15.1"

RUN curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash
RUN chmod +x /root/.gvm/scripts/gvm
ENV PATH="$PATH:/root/.gvm/scripts"

RUN gvm install go1.18
RUN gvm install go1.19
RUN gvm install go1.20

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin