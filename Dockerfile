FROM alpine:latest

RUN apk add --no-cache --update \
    cmake \
    gcc \
    g++ \
    libxml2 \
    libxslt-dev \
    make \
    musl-dev \
    sqlite-dev \
    util-linux-dev

RUN mkdir -p /fpds-conversion-utility/build
COPY . /fpds-conversion-utility/

RUN cmake -S /fpds-conversion-utility -B /fpds-conversion-utility/build \
    && cmake --build /fpds-conversion-utility/build \
    && ln -s /fpds-conversion-utility/build/src/conversion-utility /usr/local/bin/conversion-utility
