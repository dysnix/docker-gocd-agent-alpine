# GoCD Agent Docker image

[GoCD agent](https://www.gocd.io) docker image based on alpine. Uses [gocd/gocd-agent-alpine-3.10](https://hub.docker.com/r/gocd/gocd-agent-alpine-3.10) container image.

Dysnix container image bundles the following tools into the container image [dysnix/gocd-agent-alpine](https://hub.docker.com/r/dysnix/gocd-agent-alpine):

* kubectl
* helm
* helmfile

## Container image versioning

Currently container image releases are tagged as the matching Kubernetes release such as *v1.14.8*. While the other tools versions are strictly built-in. For the details refer to the [Dockerfile](Dockerfile).
