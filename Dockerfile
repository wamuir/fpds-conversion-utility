FROM debian:buster-slim

RUN apt-get update && apt-get -y install --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    liblzma-dev \
    libncurses-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2 \
    libxslt1-dev \
    tar \
    uuid-dev \
    xxd \
    zlib1g-dev

# build cmake from source
ENV CMAKE_VERSION=3.19.1
WORKDIR /opt/cmake
RUN curl -Ls https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz | tar xz
RUN cd cmake-${CMAKE_VERSION} && ./bootstrap && make -j$(nproc) install clean

# build conversion utility
ENV FPDS_STATIC=0
WORKDIR /opt/fpds-conversion-utility
COPY . .
RUN cmake -S /opt/fpds-conversion-utility -B /opt/fpds-conversion-utility/build
RUN cmake --build /opt/fpds-conversion-utility/build


FROM debian:buster-slim

RUN apt-get update && apt-get -y install --no-install-recommends \
    liblzma-dev \
    libncurses-dev \
    libsqlite3-dev \
    libxml2 \
    libxslt1-dev \
    uuid-dev \
    zlib1g

COPY --from=0 /opt/fpds-conversion-utility/build/src/conversion-utility /usr/local/bin/conversion-utility

ENTRYPOINT ["/usr/local/bin/conversion-utility"]
