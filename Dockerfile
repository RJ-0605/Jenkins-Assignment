FROM --platform=linux/amd64 jenkins/jenkins:lts
USER root

RUN apt-get update


RUN set +x \
  && env \
  && apt-get update \
  && apt-get -y upgrade \
  && apt-get -y install  python3 python3-pip jq 

#   && apt-get -y install openrc openntpd tzdata python3 python3-pip jq git

RUN jenkins-plugin-cli --plugins \
    greenballs:1.15.1

  RUN set +x \
  && apt-get install -y \
     lsb-release software-properties-common \
     apt-transport-https ca-certificates curl gnupg2 \
  && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
  && add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable" \
  && apt-get update \
  && apt-get -y upgrade \
  && apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin \
  && systemctl enable docker

# set permissions for jenkins user
RUN set +x \
    && usermod -aG staff,docker jenkins \
  && exec bash

RUN set +x \
  && curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m`" > docker-compose \
  && cp docker-compose /bin/docker-compose \
  && chmod +x /bin/docker-compose

RUN set +x \
  && apt-get clean



WORKDIR /home

# drop back to the regular jenkins user - good practice

# USER jenkins
 

# RUN usermod -aG docker 

