# This is a comment
FROM fedora:22
MAINTAINER rb2
RUN dnf -y install java-1.8.0-openjdk-headless.x86_64 tar tmux gnupg.x86_64 supervisor procps
RUN curl http://bob.nem.ninja/nis-ncc-0.6.73.tgz > nis-ncc-0.6.73.tgz
RUN curl http://bob.nem.ninja/nis-ncc-0.6.73.tgz.sig > nis-ncc-0.6.73.tgz.sig
RUN gpg --keyserver keys.gnupg.net --recv-key A46494A9
RUN gpg --verify nis-ncc-0.6.73.tgz.sig nis-ncc-0.6.73.tgz && tar zxf nis-ncc-0.6.73.tgz
RUN mkdir -p /root/nem
RUN mkdir -p /root/nem/ncc/
RUN mkdir -p /root/nem/nis/
COPY ./container_scripts/supervisord.conf /etc/
EXPOSE 7890
EXPOSE 8989
CMD ["/usr/bin/supervisord"]
