FROM nginx
RUN apt-get update
RUN apt-get install -y curl tar
RUN curl -L https://github.com/NewEconomyMovement/nem-lightwallet/archive/master.tar.gz  | tar -zx -C /usr/share/nginx/html/
RUN mv /usr/share/nginx/html/nem-lightwallet-master/lightwallet /usr/share/nginx/html
RUN rm -r /usr/share/nginx/html/nem-lightwallet-master
COPY index.html /usr/share/nginx/html/
COPY default.conf /etc/nginx/conf.d/default.conf
