FROM alpine:3.8

COPY config.toml /home/prosody-filer/

RUN set -ex \
        && adduser --disabled-password prosody-filer \
        && wget \
               --directory-prefix /home/prosody-filer/ \
                https://github.com/ThomasLeister/prosody-filer/releases/download/v1.0.0/prosody-filer \
        && chown -R prosody-filer:prosody-filer /home/prosody-filer/ \
        && chmod a+x /home/prosody-filer/prosody-filer \
        && ln -s /home/prosody-filer/prosody-filer /usr/bin/prosody-filer

USER prosody-filer

WORKDIR /home/prosody-filer/

CMD ["prosody-filer"]