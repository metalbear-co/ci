FROM buildpack-deps:bookworm

WORKDIR /tests-runner

RUN apt-get update && apt-get install -y protobuf-compiler gcc-x86-64-linux-gnu curl bison npm python3-pip bash bsdmainutils

# required for gvm
SHELL ["/bin/bash", "-c"]
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o rustup-init.sh
RUN chmod +x rustup-init.sh
RUN ./rustup-init.sh -y -c rustfmt --default-toolchain nightly-2023-04-19
ENV PATH="$PATH:/root/.cargo/bin"
RUN rustup target add --toolchain nightly-2023-04-19 x86_64-unknown-linux-gnu

RUN npm install express

RUN pip3 install --break-system-packages flask fastapi uvicorn "httptools>=0.5.0" "uvloop>=0.14.0,!=0.15.0,!=0.15.1"

RUN curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash
RUN chmod +x /root/.gvm/scripts/gvm
ENV PATH="$PATH:/root/.gvm/scripts"

RUN gvm install go1.18
RUN gvm install go1.19
RUN gvm install go1.20