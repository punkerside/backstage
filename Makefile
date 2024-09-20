export project = punkerside
export service = backstage

export AWS_DEFAULT_REGION=us-east-1
export DOCKER_BUILDKIT=0

export docker_uid=$(shell id -u)
export docker_gid=$(shell id -g)
export docker_user=$(shell whoami)

build:
	@echo "${docker_user}:x:${docker_uid}:${docker_gid}::/app:/sbin/nologin" > passwd
	@docker build -t ${project}-${service}:build -f backstage/Dockerfile.build .
	@docker run --rm -u ${docker_uid}:${docker_gid} -v ${PWD}/passwd:/etc/passwd:ro -v ${PWD}/backstage/app:/app ${project}-${service}:build