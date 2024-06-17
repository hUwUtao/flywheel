FROM docker.io/library/debian:trixie-slim AS pure

ENV DEBIAN_FRONTEND=noninteractive

FROM pure AS anybuild

RUN apt-get update -y \
    && apt-get install -y git build-essential g++ cmake

FROM anybuild AS mimalloc_build

RUN git clone https://github.com/microsoft/mimalloc /opt/mimalloc \
    && cd /opt/mimalloc \
    && cmake /opt/mimalloc \
    && make -C /opt/mimalloc \
    && chmod -R 555 /opt/mimalloc/libmimalloc.so

FROM pure AS base

RUN mkdir -p /opt/mimalloc
COPY --from=mimalloc_build /opt/mimalloc/libmimalloc.so /opt/mimalloc/libmimalloc.so
# extra bit of safety
RUN chmod -R 555 /opt/mimalloc

CMD [ "/usr/bin/env", "echo", "Hello World!" ]