FROM nginx
RUN apt-get update
RUN apt-get install -y git npm rsync curl
RUN npm cache clean -f && \
    npm install -g n && \
    n stable && \
    npm install -g gulp-cli
RUN git clone https://github.com/NemProject/NanoWallet.git && \
    cd NanoWallet && \
    npm install && sed -i -e '/browserSync.init/,+7d' gulpfile.js &&\
    gulp build-app &&\
    git checkout gulpfile.js
RUN rsync -a /NanoWallet/build/ /usr/share/nginx/html
COPY index.html /usr/share/nginx/html/
COPY default.conf /etc/nginx/conf.d/default.conf
