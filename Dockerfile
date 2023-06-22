FROM ubuntu:latest
RUN apt-get update && apt-get install -y apache2 zip unzip
ADD https://www.free-css.com/assets/files/free-css-templates/download/page292/yogast.zip /var/www/html/
WORKDIR /var/www/html
RUN unzip yogast.zip
RUN cp -rvf yogast-html/* .
RUN rm -rf yogast-html yogast.zip
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
