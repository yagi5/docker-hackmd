FROM node:6.9-alpine

# Build arguments to change source url, branch or tag
ARG SourceUrl=https://github.com/hackmdio/hackmd.git
ARG SourceVersion=master

# Add configuraton files which seem to be required for a successful bild...
COPY config.json .sequelizerc /files/

# Install all dependencies and build project
RUN apk update && \
    apk add --no-cache build-base python git && \
    # Clone the source
    git clone --depth 1 --branch $SourceVersion $SourceUrl /hackmd && \
    # Print the cloned version and clean up git files
    cd /hackmd && \
    git log --pretty=format:'%ad %h %d' --abbrev-commit --date=short -1 && echo "/n" && \
    rm -rf /hackmd/.git && \
    # Symlink configuration files
    rm -f /hackmd/config.json && ln -s /files/config.json /hackmd/config.json && \
    rm -f /hackmd/.sequelizerc && ln -s /files/.sequelizerc /hackmd/.sequelizerc && \
    # Install NPM dependencies and build project
    npm install && \
    npm run build && \
    # Clean up this layer
    npm prune --production && \
    apk del build-base python git && \
    adduser -u 10000 -h /hackmd/ -D -S hackmd && \
    chown -R hackmd /hackmd/

WORKDIR /hackmd
EXPOSE 3000
USER hackmd

# Set some default config variables
ENV NODE_ENV=production

# Add entrypoint and set command
ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
CMD ["/usr/local/bin/docker-entrypoint.sh"]
