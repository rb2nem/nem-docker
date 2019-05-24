# This is a comment
FROM fedora:25
MAINTAINER rb2
RUN dnf -y install java-1.8.0-openjdk-headless.x86_64 tar tmux supervisor procps jq unzip gnupg.x86_64
RUN dnf -y upgrade nss

# NEM software
RUN curl -L http://bob.nem.ninja/nis-0.6.97.tgz > nis-0.6.97.tgz

#RUN curl http://bob.nem.ninja/nis-0.6.97.tgz.sig > nis-0.6.97.tgz.sig
#RUN gpg --keyserver keys.gnupg.net --recv-key A46494A9
#RUN gpg --verify nis-0.6.97.tgz.sig nis-0.6.97.tgz

# New signature scheme, not always published
RUN sha=$(curl -L -s http://hugealice.nem.ninja:7890/transaction/get?hash=$(curl -L -s  http://bob.nem.ninja/nis-0.6.97.tgz.sig | grep txId | sed -e 's/txId: //') | jq -r '.transaction.message.payload[10:74]') && \
    echo "$sha nis-0.6.97.tgz"  > /tmp/sum && \
    sha256sum -c /tmp/sum

RUN tar zxf nis-0.6.97.tgz

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
