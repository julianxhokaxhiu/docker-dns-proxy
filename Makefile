###############################################################################
# ENVIRONMENT CONFIGURATION
###############################################################################
MAKEFLAGS += --no-print-directory
SHELL=/bin/bash

# Use default as default goal when running 'make'
.PHONY: default
.DEFAULT_GOAL := default

###############################################################################
# GOAL PARAMETERS
###############################################################################

# Container name
CONTAINER_NAME ?= "julianxhokaxhiu/docker-dns-proxy"

# Tag name
TAG_NAME ?= "latest"

###############################################################################
# GOALS ( safe defaults )
###############################################################################

default:
	@docker build -t $(CONTAINER_NAME):$(TAG_NAME) .

run_doh:
	@docker run --rm=true -it -e "DYNSD_USE_DOH=true" -p 53:53 -p 53:53/udp $(CONTAINER_NAME):$(TAG_NAME)

run_dot:
	@docker run --rm=true -it -e "DYNSD_USE_DOT=true" -p 53:53 -p 53:53/udp $(CONTAINER_NAME):$(TAG_NAME)

push:
	@docker push $(CONTAINER_NAME):$(TAG_NAME)

clean:
	@docker rmi $(CONTAINER_NAME):$(TAG_NAME)
