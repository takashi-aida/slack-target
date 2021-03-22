NAME := slack-target
TAG  := ailispaw/$(NAME):latest
VER  := $(shell git rev-parse --abbrev-ref HEAD)
ARGS := --build-arg VERSION=$(VER)

KUBECONFIG := $(HOME)/.tm/config.json
NAMESPACE  := t-aida

testrun:
	go run .

push:
	git push origin $(VER)

build:
	docker build $(ARGS) --tag $(TAG) .

run: build rm
	docker run -d -p 8080:8080 -e SLACK_TOKEN=$(SLACK_TOKEN) -e SLACK_CHANNEL=$(SLACK_CHANNEL) --name $(NAME) $(TAG)

rm:
	-docker rm -f $(NAME)

release: build
	docker push $(TAG)

deploy:
	kubectl --kubeconfig=$(KUBECONFIG) -n $(NAMESPACE) apply -f ksvc.yaml
	tm --config=$(KUBECONFIG) -n $(NAMESPACE) deploy -f serverless.yaml

clean:
	-docker rm -f $(NAME)
	-docker rmi $(TAG)

.PHONY: testrun push build run rm release deploy clean
