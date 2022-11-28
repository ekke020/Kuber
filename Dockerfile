FROM rust:alpine3.16 as build

WORKDIR /build

COPY . .

RUN cargo build -r
RUN cargo install --path .

FROM alpine

USER nobody:nobody
COPY --from=build /build/target/release/kubernetes /kubernetes
COPY --from=build /build/html/ /html

CMD [ "/kubernetes" ]