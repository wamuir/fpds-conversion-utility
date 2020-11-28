FROM alpine:latest

RUN apk add --no-cache --update \
    build-base \
    cmake \
    curl \
    libxml2-dev \
    libxslt-dev \
    sqlite-dev \
    sqlite-static \
    util-linux-dev \
    xxd \
    xz-dev \
    zlib-static

# build ncurses from source
#  - alpine/apk ncurses-static includes static for ncursesw
#  - cmake does not support ncursesw (https://gitlab.kitware.com/cmake/cmake/-/issues/19033)
#  - ref: apk build @ https://invisible-mirror.net/datafiles/release/ncurses.tar.gz
ENV NCURSES_VERSION=6.2
WORKDIR /opt/ncurses
RUN curl -L https://invisible-mirror.net/archives/ncurses/ncurses-${NCURSES_VERSION}.tar.gz | tar xzvf -
RUN ncurses-${NCURSES_VERSION}/configure && make install clean

# build conversion utility
ENV FPDS_STATIC=1
WORKDIR /opt/fpds-conversion-utility
COPY . .
RUN cmake -S /opt/fpds-conversion-utility -B /opt/fpds-conversion-utility/build
RUN cmake --build /opt/fpds-conversion-utility/build

FROM alpine:latest

COPY --from=0 /opt/fpds-conversion-utility/build/src/conversion-utility /usr/local/bin/conversion-utility

ENTRYPOINT ["/usr/local/bin/conversion-utility"]
