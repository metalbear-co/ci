FROM instrumentisto/rust:nightly-2023-01-31
WORKDIR /app
RUN curl -sSL https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3 get-pip.py
RUN python3 -m pip install ziglang
RUN cargo install cargo-zigbuild

RUN rustup component add --toolchain nightly rustfmt
RUN rustup target add --toolchain nightly x86_64-unknown-linux-gnu
RUN rustup target add --toolchain nightly aarch64-unknown-linux-gnu
RUN rustup target add --toolchain nightly armv7-unknown-linux-gnueabihf
RUN apt-get update && apt-get install -y gcc-aarch64-linux-gnu gcc-arm-linux-gnueabihf gcc-x86_64-linux-gnu