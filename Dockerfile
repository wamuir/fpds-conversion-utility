FROM debian:buster-slim AS builder

RUN apt-get update && apt-get -y install --no-install-recommends \
    liblzma-dev \
    libncurses-dev \
    libsqlite3-dev \
    libxml2 \
    libxslt1-dev \
    uuid-dev \
    zlib1g


FROM builder

# build cmake from source
ENV CMAKE_VERSION=3.14.7
WORKDIR /opt/cmake
RUN apt-get -y install --no-install-recommends \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    libssl-dev \
    tar
RUN c_rehash \
    && curl -fSLs https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz \
    | tar xz \
    && cd cmake-${CMAKE_VERSION} \
    && cmake . \
    && make -j$(nproc) install clean

# build conversion utility
ENV FPDS_STATIC=0
WORKDIR /opt/fpds-conversion-utility
COPY . .
RUN apt-get -y install --no-install-recommends \
    xxd
RUN cmake -S /opt/fpds-conversion-utility -B /opt/fpds-conversion-utility/build \
    && cmake --build /opt/fpds-conversion-utility/build


FROM builder

COPY --from=1 /opt/fpds-conversion-utility/build/app/conversion-utility /usr/local/bin/conversion-utility

ENTRYPOINT ["/usr/local/bin/conversion-utility"]
