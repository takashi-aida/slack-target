NAME := slack-target
TAG  := ailispaw/$(NAME):latest

build:
	docker build --tag $(TAG) .

run: build rm
	docker run -d -p 8080:8080 -e SLACK_TOKEN=$(SLACK_TOKEN) -e SLACK_CHANNEL=$(SLACK_CHANNEL) --name $(NAME) $(TAG)

push: build
	docker push $(TAG)

rm:
	-docker rm -f $(NAME)

clean: 
	-docker rm -f $(NAME)
	-docker rmi $(TAG)

.PHONY: build run push rm clean
