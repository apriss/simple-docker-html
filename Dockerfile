FROM nginx
COPY html/* /usr/share/nginx/html/
RUN CHMOD -R 777 usr/share/nginx/html/
#RUN CHOWN -R www-data:www-data usr/share/nginx/html/