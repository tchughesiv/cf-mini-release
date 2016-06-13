#! /bin/sh
sed -i '/apt-get update/d' /root/cf_nise_installer/nise_bosh/bin/init
sed -i '/exit 1/d' /root/cf_nise_installer/nise_bosh/bin/init

# change consul port to 8600
sed -i 's/DNS: 53,/DNS: 8600,/g' /var/vcap/packages/confab/src/github.com/cloudfoundry-incubator/consul-release/src/confab/config/consul_config_definer.go
sed -i 's/DNS: 53,/DNS: 8600,/g' /root/cf_nise_installer/cf-release/src/consul-release/src/confab/config/consul_config_definer.go