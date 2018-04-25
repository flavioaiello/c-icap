FROM debian:stretch-slim

RUN set -ex ;\
    apt-get update ;\
    apt-get install -y --allow-unauthenticated --no-install-recommends c-icap libc-icap-mod-virus-scan libc-icap-mod-contentfiltering ;\
    rm -rf /var/lib/apt/lists/* ;\
    mkdir -p /var/run/c-icap/ ;\
    chown -R c-icap:c-icap /var/run/c-icap/

# Add local files to image
COPY files /

EXPOSE 1344/tcp

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/usr/bin/c-icap", "-f", "/etc/c-icap/c-icap.conf", "-N" ,"-D"]
