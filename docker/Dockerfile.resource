FROM rust:slim-bookworm AS builder

RUN apt-get update \
    && apt-get install -y protobuf-compiler \
    && apt-get clean

WORKDIR /usr/src/rmcs-workspace
COPY . .

RUN cargo install --path ./rmcs-api-server --bin resource_server

FROM debian:bookworm-slim

COPY --from=builder /usr/local/cargo/bin/resource_server /usr/local/bin/resource_server

ENTRYPOINT ["resource_server"]
