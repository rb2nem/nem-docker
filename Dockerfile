# This is a comment
FROM fedora:22
MAINTAINER rb2
#RUN apt-get update && apt-get install -y ruby ruby-dev
#RUN gem install sinatra
RUN dnf -y install java-1.8.0-openjdk-headless.x86_64 tar tmux gnupg.x86_64 
RUN curl http://bob.nem.ninja/nis-ncc-0.6.72.tgz > nis-ncc-0.6.72.tgz
RUN curl http://bob.nem.ninja/nis-ncc-0.6.72.tgz.sig > nis-ncc-0.6.72.tgz.sig
RUN gpg --keyserver keys.gnupg.net --recv-key A46494A9
RUN gpg --verify nis-ncc-0.6.72.tgz.sig nis-ncc-0.6.72.tgz && tar zxf nis-ncc-0.6.72.tgz
RUN mkdir -p /root/nem
COPY ./container_scripts/start.sh /
COPY ./config-user.properties /package/nis/
# default arguments to entry point:
CMD ["nis"]
ENTRYPOINT ["/start.sh"]
