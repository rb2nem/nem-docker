# This is a comment
FROM fedora:25
MAINTAINER rb2
RUN dnf -y install java-1.8.0-openjdk-headless.x86_64 tar tmux gnupg.x86_64 supervisor procps jq
RUN dnf -y upgrade nss
RUN curl http://bob.nem.ninja/nis-ncc-0.6.83.tgz > nis-ncc-0.6.83.tgz
RUN sha=$(curl -s http://bigalice3.nem.ninja:7890/transaction/get?hash=$(curl -s  http://bob.nem.ninja/nis-ncc-0.6.83.tgz.sig | grep txId | sed -e 's/txId: //') | jq -r '.transaction.message.payload[10:]') && \
    echo "$sha nis-ncc-0.6.83.tgz"  > /tmp/sum && \
    sha256sum -c /tmp/sum && tar xf nis-ncc-0.6.83.tgz
RUN useradd nem
RUN mkdir -p /home/nem/nem/ncc/
RUN mkdir -p /home/nem/nem/nis/
RUN chown nem /home/nem/nem -R
COPY ./container_scripts/supervisord.conf /etc/
EXPOSE 7890
EXPOSE 8989
CMD ["/usr/bin/supervisord"]
