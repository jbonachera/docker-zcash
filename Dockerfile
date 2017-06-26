FROM jbonachera/arch
ENV VERSION=1.0.10-1
ENV HASH=3024471640b0aea682f6f5b686e14f81e413e2bb69eb5d478061d07793dd9714
RUN pacman -S --noconfirm curl wget
RUN curl -sLo /tmp/zcash.tgz https://z.cash/downloads/zcash-${VERSION}-linux64.tar.gz && \
    sha256sum /tmp/zcash.tgz | grep $HASH && \
    mkdir /usr/share/zcash/ && \
    tar -xzf /tmp/zcash.tgz -C /usr/share/zcash/ && \
    ln -sf /usr/share/zcash/zcash-$VERSION/bin/* /usr/bin/
RUN useradd -r zcashd -d /var/lib/zcashd && \
    mkdir /var/lib/zcashd && \
    chown zcashd: /var/lib/zcashd
USER zcashd
RUN mkdir /var/lib/zcashd/.zcash/
COPY entrypoint /bin/entrypoint
ENTRYPOINT /bin/entrypoint
VOLUME /var/lib/zcashd/
