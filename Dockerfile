FROM alpine:latest

RUN apk add --no-cache --update \
    build-base \
    cmake \
    libxml2-dev \
    libxslt-dev \
    sqlite-dev \
    sqlite-static \
    util-linux-dev \
    xz-dev \
    zlib-static

COPY . /fpds-conversion-utility/

ENV FPDS_STATIC=1

RUN cmake \
    -S /fpds-conversion-utility \
    -B /fpds-conversion-utility/build

RUN cmake \
    --build /fpds-conversion-utility/build

FROM alpine:latest

COPY --from=0 /fpds-conversion-utility/build/src/conversion-utility /usr/local/bin/conversion-utility

ENTRYPOINT ["/usr/local/bin/conversion-utility"]
