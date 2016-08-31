# This is a comment
FROM fedora:22
MAINTAINER rb2
RUN dnf -y install java-1.8.0-openjdk-headless.x86_64 tar tmux gnupg.x86_64 supervisor procps unzip
RUN dnf -y upgrade nss

# NEM software
RUN curl http://bob.nem.ninja/nis-ncc-0.6.79.tgz > nis-ncc-0.6.79.tgz
RUN curl http://bob.nem.ninja/nis-ncc-0.6.79.tgz.sig > nis-ncc-0.6.79.tgz.sig
RUN gpg --keyserver keys.gnupg.net --recv-key A46494A9
RUN gpg --verify nis-ncc-0.6.79.tgz.sig nis-ncc-0.6.79.tgz && tar zxf nis-ncc-0.6.79.tgz

# servant
RUN curl -L https://github.com/rb2nem/nem-servant/raw/master/servant.zip > servant.zip
RUN unzip servant.zip

RUN useradd --uid 1000 nem

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
