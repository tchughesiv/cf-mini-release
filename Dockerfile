# Cloud Foundry release
# version 0.1
FROM tchughesiv/cf-mini-base:v205
MAINTAINER Tommy Hughes <tchughesiv@gmail.com>

WORKDIR /root
ENV HOME /root
ENV INSTALLER_BRANCH v205
ENV NISE_DOMAIN cf-mini.example
ENV NISE_PASSWORD c1oudc0w
RUN echo Etc/UTC > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

ADD dynamic_adds.sh /root/
ADD dynamic_adds_2.sh /root/
ADD cleanup.sh /root/

RUN apt-get update && curl -s -k -B https://raw.githubusercontent.com/tchughesiv/cf_nise_installer/${INSTALLER_BRANCH}/scripts/bootstrap.sh > /root/bootstrap.sh && chmod u+x /root/*.sh && sed -i 's/.\/scripts\/install.sh/\/root\/dynamic_adds.sh\n.\/scripts\/install.sh\n\/root\/cleanup.sh/g' ./bootstrap.sh && ./bootstrap.sh && rm /root/*.sh && apt-get -y remove --purge apparmor
