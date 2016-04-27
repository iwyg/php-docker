FROM nginx:latest
# Remove default nginx configs.
RUN rm /etc/nginx/nginx.conf
RUN rm /etc/nginx/conf.d/*.conf
RUN if [ -d '/etc/nginx/sites-enabled' ]; then rm -rf /etc/nginx/sites-enabled; fi

COPY config/nginx.conf /etc/nginx/
#FROM nginx:latest
#
## Remove default nginx configs.
#RUN rm /etc/nginx/nginx.conf
#RUN if [ -d /etc/nginx/conf.d ]; then rm -rf /etc/nginx/conf.d/*; fi
#RUN if [ -d /etc/nginx/sites-enabled ]; then rm -rf /etc/nginx/sites-enabled; fi
#
#ADD config/nginx.conf /etc/nginx/nginx.conf
#ADD config/sites-enabled /etc/nginx/sites-enabled

EXPOSE 80 443
