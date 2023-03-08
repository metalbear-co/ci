FROM buildpack-deps:buster

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o rustup-init.sh
RUN chmod +x rustup-init.sh
RUN ./rustup-init.sh -y --no-modify-path -c rustfmt --default-toolchain nightly-2023-01-31
RUN /root/.cargo/bin/rustup target add x86_64-unknown-linux-gnu aarch64-unknown-linux-gnu armv7-unknown-linux-gnueabihf

RUN curl -sSL https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3 get-pip.py
RUN python3 -m pip install ziglang
RUN /root/.cargo/bin/cargo install cargo-zigbuild

RUN apt-get update && apt-get install -y gcc-aarch64-linux-gnu gcc-arm-linux-gnueabihf gcc-x86-64-linux-gnu