FROM node:lts-alpine
LABEL author "Julian Xhokaxhiu <https://julianxhokaxhiu.com>"

# Configurable environment variables
####################################

# Use DNS-over-HTTPS
ENV DYNSD_USE_DOH "false"

# Use DNS-over-TLS
ENV DYNSD_USE_DOT "false"

# Copy required files and fix permissions
#########################################

COPY src/* /root/

# Set the work directory
########################

WORKDIR /root

# Fix permissions
#################

RUN chmod 0644 * \
    && chmod 0755 *.sh

# Install required packages
##############################

RUN apk --update add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
    bash \
    supervisor \
    mkcert

# Install dynsdjs and dynsdjs-plugin-doh-dot
############################################

RUN npm install -g dynsdjs dynsdjs-plugin-doh-dot

# Cleanup
#########

RUN find /usr/local \
      \( -type d -a -name test -o -name tests \) \
      -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
      -exec rm -rf '{}' + \
    && rm -rf /var/cache/apk/*

# Replace default configurations
################################
RUN rm /etc/supervisord.conf \
    && mv /root/supervisord.conf /etc

# Allow redirection of stdout to docker logs
############################################
RUN ln -sf /proc/1/fd/1 /var/log/docker.log

# Expose required ports
#######################

EXPOSE 53
EXPOSE 53/udp

# Change Shell
##############
SHELL ["/bin/bash", "-c"]

# Set the entry point to init.sh
###########################################

ENTRYPOINT /root/init.sh
