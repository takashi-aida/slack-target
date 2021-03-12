NAME := slack-target
TAG  := ailispaw/$(NAME):latest

KUBECONFIG := $(HOME)/.tm/config.json
NAMESPACE  := t-aida

build:
	docker build --tag $(TAG) .

run: build rm
	docker run -d -p 8080:8080 -e SLACK_TOKEN=$(SLACK_TOKEN) -e SLACK_CHANNEL=$(SLACK_CHANNEL) --name $(NAME) $(TAG)

rm:
	-docker rm -f $(NAME)

push: build
	docker push $(TAG)

deploy:
	kubectl --kubeconfig=$(KUBECONFIG) -n $(NAMESPACE) apply -f ksvc.yaml

clean: 
	-docker rm -f $(NAME)
	-docker rmi $(TAG)

.PHONY: build run rm push deploy clean
