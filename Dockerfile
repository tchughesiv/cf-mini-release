# Cloud Foundry release
# version 0.2
FROM tchughesiv/cf-mini-base:v215
MAINTAINER Tommy Hughes <tchughesiv@gmail.com>

WORKDIR /root
ENV HOME /root
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8
RUN echo Etc/UTC > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

ENV INSTALLER_BRANCH v215
ENV NISE_DOMAIN cf-mini.example
ENV NISE_PASSWORD c1oudc0w

ADD dynamic_adds.sh /root/
ADD dynamic_adds_2.sh /root/
ADD cleanup.sh /root/

RUN apt-get update && curl -s -k -B https://raw.githubusercontent.com/tchughesiv/cf_nise_installer/${INSTALLER_BRANCH}/scripts/bootstrap.sh > /root/bootstrap.sh && chmod u+x /root/*.sh && sed -i 's/.\/scripts\/install.sh/\/root\/dynamic_adds.sh\n.\/scripts\/install.sh\n\/root\/cleanup.sh/g' ./bootstrap.sh && sed -i 's/com\/yudai\/cf_nise_installer/com\/tchughesiv\/cf_nise_installer/g' ./bootstrap.sh && ./bootstrap.sh && rm /root/*.sh && apt-get -y remove --purge apparmor
