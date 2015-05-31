# This is a comment
FROM fedora:22
MAINTAINER rb2
#RUN apt-get update && apt-get install -y ruby ruby-dev
#RUN gem install sinatra
RUN dnf -y install java-1.8.0-openjdk-headless.x86_64 tar tmux gnupg.x86_64 
RUN curl http://bob.nem.ninja/nis-ncc-0.6.31.tgz > nis-ncc-0.6.31.tgz
RUN curl http://bob.nem.ninja/nis-ncc-0.6.31.tgz.sig > nis-ncc-0.6.31.tgz.sig
RUN gpg --keyserver keys.gnupg.net --recv-key A46494A9
RUN gpg --verify nis-ncc-0.6.31.tgz.sig nis-ncc-0.6.31.tgz && tar zxf nis-ncc-0.6.31.tgz
COPY ./start.sh /
# default arguments to entry point:
CMD ["nis"]
ENTRYPOINT ["/start.sh"]
