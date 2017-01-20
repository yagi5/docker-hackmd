FROM node:6.9-alpine

ARG VERSION=master

# Add files
ADD config.js /files/config.js
ADD config.json /files/config.json
ADD .sequelizerc /files/.sequelizerc

RUN apk add --no-cache build-base alpine-sdk python git && \
#   Add Source
    git clone https://github.com/hackmdio/hackmd.git -b $VERSION /hackmd && \
    cd /hackmd && \
    rm -f /hackmd/public/js/config.js && ln -s /files/config.js /hackmd/public/js/config.js && \
    rm -f /hackmd/config.json && ln -s /files/config.json /hackmd/config.json && \
    rm -f /hackmd/.sequelizerc && ln -s /files/.sequelizerc /hackmd/.sequelizerc && \

#   Install dependencies
    npm install && \
    npm run build:prod && \

#   Clean up image
    npm prune --production && \
    apk del build-base alpine-sdk python git && \
    adduser -u 10000 -h /hackmd/ -D -S hackmd && \
    chown -R hackmd /hackmd/

ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

WORKDIR /hackmd

EXPOSE 3000

USER hackmd

CMD ["/usr/local/bin/docker-entrypoint.sh"]
