# This is a comment
FROM fedora:22
MAINTAINER rb2
RUN dnf -y install java-1.8.0-openjdk-headless.x86_64 tar tmux gnupg.x86_64 supervisor procps
RUN curl http://bob.nem.ninja/nis-ncc-0.6.77.tgz > nis-ncc-0.6.77.tgz
RUN curl http://bob.nem.ninja/nis-ncc-0.6.77.tgz.sig > nis-ncc-0.6.77.tgz.sig
RUN gpg --keyserver keys.gnupg.net --recv-key A46494A9
RUN gpg --verify nis-ncc-0.6.77.tgz.sig nis-ncc-0.6.77.tgz && tar zxf nis-ncc-0.6.77.tgz
RUN useradd nem
RUN mkdir -p /home/nem/nem/ncc/
RUN mkdir -p /home/nem/nem/nis/
RUN chown nem /home/nem/nem -R
COPY ./container_scripts/supervisord.conf /etc/
EXPOSE 7890
EXPOSE 8989
CMD ["/usr/bin/supervisord"]
