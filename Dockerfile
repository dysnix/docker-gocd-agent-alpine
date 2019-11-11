ARG RELEASE
FROM gocd/gocd-agent-alpine-3.10:${RELEASE}

## Dysnix tools version
#  Container image tag versioning supposed to map to the kubernetes releases
#
ENV \
  HELM_VERSION=v2.16.0 \
  HELM_SHA256=1bf073681554bdabec1eb308f55548fbf0d09733ee901715db870066294d6822 \
  HELMFILE_VERSION=v0.90.8 \
  HELMFILE_SHA256=03d07f7c4ceabb1592a5fdd1c9c97cf45618bc46f795f739232246131808d46b \
  SOPS_VERSION=3.4.0 \
  SOPS_SHA256=369ceb213c6fd84d76d89d82f7a63e2226b00f5128c7bb84c7ebcfaffbde6139

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
  ## \
  ## install helm \
  ( curl -sSL https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | \
    DESIRED_VERSION="${HELM_VERSION}" HELM_INSTALL_DIR="/usr/local/bin" bash -s && \
    cd /usr/local/bin && printf "${HELM_SHA256}  helm" | sha256sum -c && chmod 755 helm ) && \
  ## \
  ## install sops
  ( cd /usr/local/bin && curl -#SLo sops https://github.com/mozilla/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux && \
      printf "${SOPS_SHA256}  sops" | sha256sum -c && chmod 755 sops ) && \
  ## install helmfile \
  ( cd /usr/local/bin && curl -#SLo helmfile \
    "https://github.com/roboll/helmfile/releases/download/${HELMFILE_VERSION}/helmfile_linux_amd64" && \
      printf "${HELMFILE_SHA256}  helmfile" | sha256sum -c && chmod 755 helmfile ) && \
  ## \
  ## clean up \
  apk del --purge .build-deps && \
  rm -rf /tmp/*.apk

USER go

## Initialization
RUN \
  helm init --client-only && \
  helm plugin install https://github.com/futuresimple/helm-secrets --version master
