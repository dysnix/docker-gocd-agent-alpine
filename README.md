[![Go to Docker Hub](https://img.shields.io/badge/Docker%20Hub-%E2%86%92-blue.svg)](https://hub.docker.com/r/dysnix/gocd-agent-alpine/) [![](https://images.microbadger.com/badges/version/dysnix/gocd-agent-alpine.svg)](https://microbadger.com/images/dysnix/gocd-agent-alpine) [![](https://images.microbadger.com/badges/image/dysnix/gocd-agent-alpine.svg)](https://microbadger.com/images/dysnix/gocd-agent-alpine)
# GoCD Agent Docker image

[GoCD agent](https://www.gocd.io) docker image based on alpine. Uses [gocd/gocd-agent-alpine-3.10](https://hub.docker.com/r/gocd/gocd-agent-alpine-3.10) container image.

Dysnix container image bundles the following tools into the container image [dysnix/gocd-agent-alpine](https://hub.docker.com/r/dysnix/gocd-agent-alpine):

* kubectl
* helm
* helmfile

## Container image versioning

Currently container image releases are tagged as the matching those of the upstream gocd alpine agent. Also the image tag might contain a release suffix (ex: `-r4`) in this case two tags will be created at the same time. While tools versions are strictly built-in. For the details refer to the [Dockerfile](Dockerfile).
