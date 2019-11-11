ARG RELEASE
FROM gocd/gocd-agent-alpine-3.10:${RELEASE}

## Dysnix tools version
#  Container image tag versioning supposed to map to the kubernetes releases
#
ENV \
  HELM_VERSION=v2.16.0 \
  HELMFILE_VERSION=v0.90.8

## Dysnix deployment tools
#
USER root
RUN \
  ## note: Some of tools like coreutils are not virtual, since targeted for use on the agent
  apk add --no-cache --virtual .build-deps curl openssl && \
  apk add --no-cache coreutils && \
  ## install kubectl \
  ( cd /usr/local/bin && stable_version=$(curl -sL https://storage.googleapis.com/kubernetes-release/release/stable.txt) && \
    curl -#SLO https://storage.googleapis.com/kubernetes-release/release/${stable_version}/bin/linux/amd64/kubectl ) && \
  ## install helm \
  curl -sSL https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | \
    DESIRED_VERSION="${HELM_VERSION}" HELM_INSTALL_DIR="/usr/local/bin" sh -s  && \
  ## install helmfile \
  curl -#SLo /usr/local/bin/helmfile \
    "https://github.com/roboll/helmfile/releases/download/${HELMFILE_VERSION}/helmfile_linux_amd64" && \
    chmod 755 /usr/local/bin/helmfile && \
  ## clean up \
  apk del --purge .build-deps && \
  rm -rf /tmp/*.apk

USER go

## Initialization
RUN \
  helm init --client-only && \
  helm plugin install https://github.com/futuresimple/helm-secrets --version master
