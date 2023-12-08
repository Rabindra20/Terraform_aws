.PHONY: help 
.DEFAULT_GOAL := help
APP_ROOT ?= $(shell 'pwd')
BRANCH := $(shell git for-each-ref --format='%(objectname) %(refname:short)' refs/heads | awk "/^$$(git rev-parse HEAD)/ {print \$$2}")
HASH := $(shell git rev-parse HEAD)
# TERRAFORM INSTALL

version  ?= "1.4.6"
os       ?= $(shell uname|tr A-Z a-z)
ifeq ($(shell uname -m),x86_64)
  arch   ?= "amd64"
endif
ifeq ($(shell uname -m),i686)
  arch   ?= "386"
endif
ifeq ($(shell uname -m),aarch64)
  arch   ?= "arm"
endif

ifndef terraform
  install ?= "true"
endif
ifeq ("$(upgrade)", "true")
  install ?= "true"
endif

install: ## Install terraform and dependencies
ifeq ($(install),"true")
	@wget -O /usr/bin/terraform.zip https://releases.hashicorp.com/terraform/$(version)/terraform_$(version)_$(os)_$(arch).zip
	@unzip -d /usr/bin /usr/bin/terraform.zip && rm /usr/bin/terraform.zip
endif
	@terraform --version
  @cat $(APP_ROOT)


init:  ## Initialize directory
	terraform init

plan:  ## Check infrastructure in local
	terraform plan

apply: ## Create infrastructure
	 terraform apply

help:
	@printf "\033[32mTerraform-makefile v$(version)\033[0m\n\n"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
