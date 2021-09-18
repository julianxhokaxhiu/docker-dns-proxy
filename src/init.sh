#!/usr/bin/env bash

# Init script
###########################################################

# Generate certificates
mkcert -install
mkcert -key-file key.pem -cert-file cert.pem localhost 127.0.0.1 ::1

# Export required environment variables
export DYNSD_DOT_PRIVATE_KEY="$(pwd)/key.pem"
export DYNSD_DOT_CERTIFICATE="$(pwd)/cert.pem"

# Start supervisor
/usr/bin/supervisord -c /etc/supervisord.conf
