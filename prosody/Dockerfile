FROM alpine:3.8

# Set the locale
ARG PREFIX
ENV PATH $PATH:${PREFIX}/bin

COPY wait.sh /

# Install dependencies
RUN set -ex \
        \
        && apk add --no-cache --virtual .fetch-deps \
                ca-certificates \
                curl \
                unzip \
        \
        && apk add --no-cache --virtual .build-deps \
                make \
                gcc \
                mercurial \
                lua5.1-dev \
                libidn-dev \
                openssl-dev \
                # libevent-dev \
                libc-dev \
                linux-headers \
                luarocks5.1 \
                git \
        \
        && apk add --no-cache --virtual .prosody-deps \
                postgresql-client \
                openssl \
                libidn \
                lua5.1 \
                lua5.1-socket \
                lua5.1-sec \
                lua5.1-lzlib \
                lua5.1-filesystem \
                lua5.1-expat \
                lua5.1-dbi-postgresql \
                && luarocks-5.1 install luabitop \
        \
        && addgroup prosody \
        && adduser -G prosody -s /bin/sh -D -H prosody \
        && mkdir -p ${PREFIX} /prosody-build \
        && chown -R prosody:prosody ${PREFIX} \
        && wget https://prosody.im/downloads/source/prosody-0.11.1.tar.gz \
        && tar \
                --extract \
                --file prosody-0.11.1.tar.gz \
                --directory /prosody-build \
                --strip-components 1 \
        && rm prosody-0.11.1.tar.gz \
        && cd /prosody-build \
        && ./configure \
                --prefix=${PREFIX} \
                --no-example-certs \
        && make -j "$(nproc)" \
        && make install \
        \
        && hg clone https://hg.prosody.im/prosody-modules/ ${PREFIX}/lib/prosody/prosody-community \
        && mkdir /var/run/prosody && chown prosody:prosody /var/run/prosody \
        && apk del .fetch-deps .build-deps \
        && rm -rf \
                /prosody-build \
                /opt/prosody-0.11.1/share \
        && find /usr/local -name '*.a' -delete \
        \
        && chmod a+x /wait.sh

# COPY prosody.cfg.lua ${PREFIX}/etc/prosody/prosody.cfg.lua
# COPY mail.solay.ga.cfg.lua ${PREFIX}/etc/prosody/conf.d/

EXPOSE 5000 5222 5223 5269 5280 5281

USER prosody

CMD ["/wait.sh", "db", "prosodyctl", "start"]