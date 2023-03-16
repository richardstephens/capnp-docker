FROM alpine:3.17 AS build

RUN apk add git build-base autoconf automake libtool linux-headers

WORKDIR /
RUN git clone https://github.com/capnproto/capnproto.git && cd capnproto && git checkout v0.10.3 && rm -rf .git
WORKDIR /capnproto/c++

RUN autoreconf -i
RUN ./configure
RUN make -j32 check
RUN make install

WORKDIR /
RUN git clone https://github.com/capnproto/capnproto-java.git && cd capnproto-java && git checkout v0.1.15 && rm -rf .git

WORKDIR /capnproto-java
RUN make
RUN make install

FROM alpine:3.17

RUN apk add libstdc++

COPY --from=build /usr/local/bin/* /usr/local/bin
COPY --from=build /usr/local/lib/* /usr/local/lib
COPY --from=build /usr/local/include/capnp /usr/local/include/capnp

