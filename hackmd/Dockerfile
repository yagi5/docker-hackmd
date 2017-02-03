FROM node:6-alpine

# Build arguments to change source url, branch or tag
ARG SourceUrl=https://github.com/hackmdio/hackmd.git
ARG SourceVersion=0.5.0


# Add configuraton files which seem to be required for a successful bild...
ADD config.js config.json .sequelizerc /files/

# Install all dependencies and build project
RUN apk update && \
    apk add --no-cache build-base python git && \
    # Clone the source
    git clone --depth 1 --branch $SourceVersion $SourceUrl /hackmd && \
    # Symlink configuration files
    rm -f /hackmd/public/js/config.js && ln -s /files/config.js /hackmd/public/js/config.js && \
    rm -f /hackmd/config.json && ln -s /files/config.json /hackmd/config.json && \
    rm -f /hackmd/.sequelizerc && ln -s /files/.sequelizerc /hackmd/.sequelizerc && \
    # Install NPM dependencies
    cd /hackmd && \
    npm install && \
    # Build project! (Older versions uses npm script "build:prod", newer version uses just "build")
    build_script_name="$(if grep -q 'build:prod' package.json; then echo 'build:prod'; else echo 'build'; fi)" && \
    npm run $build_script_name && \
    # Clean up this layer
    npm prune --production && \
    apk del build-base python git && \
    adduser -u 10000 -h /hackmd/ -D -S hackmd && \
    chown -R hackmd /hackmd/

WORKDIR /hackmd
EXPOSE 3000
USER hackmd

# Set some default config variables
ENV NODE_ENV=docker
ENV HMD_DB_URL=postgres://hackmd:hackmdpass@postgres:5432/hackmd
ENV HMD_URL_ADDPORT=true

# Add entrypoint and set command
ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
CMD ["/usr/local/bin/docker-entrypoint.sh"]
