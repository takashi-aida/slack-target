FROM alpine:3.13

ARG VERSION="master"
ENV GOPATH="/tmp/go"
EXPOSE 8080

RUN apk --no-cache add --virtual build-deps go make git \
 && mkdir -p "${GOPATH}/src/github.com/takashi-aida" \
 && cd "${GOPATH}/src/github.com/takashi-aida" \
 && git clone --depth 1 --branch ${VERSION} "https://github.com/takashi-aida/slack-target" \
 && cd slack-target \
 && go get -v \
 && go install \
 && install "${GOPATH}/bin/slack-target" /usr/local/bin/ \
 && apk del build-deps \
 && rm -rf "${GOPATH}"

CMD [ "slack-target" ]
