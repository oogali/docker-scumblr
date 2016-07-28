DOCKER=/usr/bin/docker
RUBY_VERSION=2.0.0-p481
TAG=netflix/scumblr

build:
	$(DOCKER) build --rm=true --tag=$(TAG) --build-arg RUBY_VERSION=$(RUBY_VERSION) $(TAG)

tag: build
	$(DOCKER) tag $(TAG) localhost:5000/$(TAG)

push: tag
	$(DOCKER) push localhost:5000/$(TAG)

.PHONY: build
