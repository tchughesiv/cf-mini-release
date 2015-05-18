# Cloud Foundry release
# version 0.1
FROM tchughesiv/cf-mini-base:v205
MAINTAINER Tommy Hughes <tchughesiv@gmail.com>

WORKDIR /root
ENV HOME /root
ENV INSTALLER_BRANCH v205
ENV NISE_DOMAIN cf.mini
ENV NISE_PASSWORD c1oudc0w

ADD dynamic_adds.sh /root/
ADD dynamic_adds_2.sh /root/

RUN curl -s -k -B https://raw.githubusercontent.com/tchughesiv/cf_nise_installer/${INSTALLER_BRANCH}/scripts/bootstrap.sh > /root/bootstrap.sh && chmod u+x /root/*.sh && sed -i 's/.\/scripts\/install.sh/\/root\/dynamic_adds.sh\n.\/scripts\/install.sh\ncd \/root\/cf_nise_installer\/nise_bosh\n. ~\/.profile\nbundle install/g' ./bootstrap.sh && ./bootstrap.sh && rm /root/*.sh && rm -rf /var/lib/apt/lists/* && apt-get clean
