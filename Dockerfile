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

RUN mkdir -p /fpds-conversion-utility/build
COPY . /fpds-conversion-utility/

RUN cmake \
    -S /fpds-conversion-utility \
    -B /fpds-conversion-utility/build \
    -D CMAKE_C_STANDARD_LIBRARIES="-static"

RUN cmake \
    --build /fpds-conversion-utility/build

FROM alpine:latest

COPY --from=0 /fpds-conversion-utility/build/src/conversion-utility /usr/local/bin/conversion-utility

ENTRYPOINT ["/usr/local/bin/conversion-utility"]
