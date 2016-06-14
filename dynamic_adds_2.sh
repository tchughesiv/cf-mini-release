#! /bin/sh
sed -i '/apt-get update/d' /root/cf_nise_installer/nise_bosh/bin/init
sed -i '/exit 1/d' /root/cf_nise_installer/nise_bosh/bin/init

# change consul port to 8600
cd /root/cf_nise_installer/cf-release
git submodule update --init
cd /root/cf_nise_installer/cf-release/src/consul-release/
git submodule update --init
sed -i 's/DNS: 53,/DNS: 8600,/g' /root/cf_nise_installer/cf-release/src/consul-release/src/confab/config/consul_config_definer.go