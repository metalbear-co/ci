FROM buildpack-deps:buster

RUN apt-get update && apt-get install -y protobuf-compiler clang rsync gcc-x86-64-linux-gnu

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o rustup-init.sh
RUN chmod +x rustup-init.sh
RUN ./rustup-init.sh -y -c rustfmt --default-toolchain nightly-2024-10-11
ENV PATH="$PATH:/root/.cargo/bin"
RUN rustup target add --toolchain nightly-2024-10-11 x86_64-unknown-linux-gnu
