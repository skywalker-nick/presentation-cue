# syntax=docker/dockerfile:1

FROM golang:1.20
ENV CUE_VERSION=latest

LABEL maintainer="nick <skywalker.nick@gmail.com>"
RUN go install cuelang.org/go/cmd/cue@${CUE_VERSION}