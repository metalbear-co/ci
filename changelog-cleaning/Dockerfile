FROM rust:1.80-slim AS build
WORKDIR /app
COPY Cargo.toml .
RUN mkdir -p src && echo "fn main() { println!(\"bootstrap\"); }" > src/main.rs
RUN cargo build --release && rm -rf target/release/deps/changelog_cleaning*
COPY src ./src
RUN cargo build --release

FROM debian:bookworm-slim AS runtime
RUN useradd -ms /bin/bash runner
WORKDIR /home/runner
COPY --from=build /app/target/release/changelog-cleaning /usr/local/bin/changelog-cleaning
USER runner
ENTRYPOINT ["/usr/local/bin/changelog-cleaning"]

