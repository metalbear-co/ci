FROM buildpack-deps:buster

RUN apt-get update && apt-get install -y protobuf-compiler gcc-aarch64-linux-gnu gcc-arm-linux-gnueabihf gcc-x86-64-linux-gnu
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o rustup-init.sh
RUN chmod +x rustup-init.sh
RUN ./rustup-init.sh -y -c rustfmt --default-toolchain nightly-2023-03-29
ENV PATH="$PATH:/root/.cargo/bin"
RUN rustup target add --toolchain nightly-2023-03-29 x86_64-unknown-linux-gnu aarch64-unknown-linux-gnu

RUN curl -sSL https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3 get-pip.py
RUN CARGO_NET_GIT_FETCH_WITH_CLI=true python3 -m pip install cargo-zigbuild
