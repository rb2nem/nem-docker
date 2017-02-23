# This is a comment
FROM fedora:25
MAINTAINER rb2
RUN dnf -y install java-1.8.0-openjdk-headless.x86_64 tar tmux supervisor procps jq unzip
RUN dnf -y upgrade nss

# NEM software
RUN curl http://bob.nem.ninja/nis-ncc-0.6.83.tgz > nis-ncc-0.6.83.tgz
RUN sha=$(curl -s http://bigalice3.nem.ninja:7890/transaction/get?hash=$(curl -s  http://bob.nem.ninja/nis-ncc-0.6.83.tgz.sig | grep txId | sed -e 's/txId: //') | jq -r '.transaction.message.payload[10:]') && \
    echo "$sha nis-ncc-0.6.83.tgz"  > /tmp/sum && \
    sha256sum -c /tmp/sum && tar zxf nis-ncc-0.6.83.tgz
RUN useradd --uid 1000 nem
RUN mkdir -p /home/nem/nem/ncc/
RUN mkdir -p /home/nem/nem/nis/
RUN chown nem /home/nem/nem -R

# servant
RUN curl -L https://github.com/rb2nem/nem-servant/raw/master/servant.zip > servant.zip
RUN unzip servant.zip


# the sample is used as default config in the container
COPY ./custom-configs/supervisord.conf.sample /etc/supervisord.conf
# wallet
EXPOSE 7777
# NIS
EXPOSE 7890
# servant
EXPOSE 7880
# NCC
EXPOSE 8989
CMD ["/usr/bin/supervisord"]
