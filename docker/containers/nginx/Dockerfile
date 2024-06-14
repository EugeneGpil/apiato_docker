FROM nginx:1.25.5-bookworm

COPY ./conf.d /etc/nginx/conf.d

ARG APP_HOST
RUN sed -i -e "s#%%DOMAIN%%#${APP_HOST}#" $(find /etc/nginx/conf.d/ -type f) && \
    apt-get update && \
    apt-get install acl -y --no-install-recommends
