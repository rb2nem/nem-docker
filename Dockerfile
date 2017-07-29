FROM ubuntu:17.04

RUN apt-get update
RUN apt-get install -y git npm rsync curl nginx
RUN npm cache clean -f && \
    npm install -g n && \
    n stable && \
    npm install -g gulp-cli
RUN git clone https://github.com/NemProject/NanoWallet.git && \
    cd NanoWallet && \
    npm install && sed -i -e '/browserSync.init/,+12d' gulpfile.js &&\
    gulp &&\
    git checkout gulpfile.js
RUN rsync -a /NanoWallet/build/ /usr/share/nginx/html
COPY files/build /usr/bin
RUN chmod 555 /usr/bin/build
COPY index.html /usr/share/nginx/html/
COPY default.conf /etc/nginx/conf.d/default.conf
