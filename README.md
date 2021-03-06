# Another Slack Target for TriggerMesh

The primary purpose of this repository is for me to learn writing a serverless task/service on TriggerMesh.

## Problem
  - The current Slack Target implementation assumes that a Slack API method to post is at the `type` attribute in a CloudEvent.
  - The current Slack Target implementation assumes that a Slack channel to post is at the `channel` in the `data` of a CloudEvent.

## Proposal
  - They should be independent from any source of a CloudEvent.
  - They should be configurable from outside of the Target like environment variables.
    - `SLACK_TOKEN`
    - `SLACK_API_METOD` or just use `chat.postMessage` method to post.
    - `SLACK_CHANNEL`
  - As a result, any CloudEvent can be delivered to multiple Slack targets simultaneously.

## Resources
  - https://docs.triggermesh.io/targets/slack/
  - https://github.com/triggermesh/bringyourown
  - https://docs.triggermesh.io/apis/
  - https://knative.dev/docs/reference/api/
  - https://github.com/cloudevents/sdk-go
  - https://github.com/slack-go/slack
  - https://api.slack.com/methods/chat.postMessage
