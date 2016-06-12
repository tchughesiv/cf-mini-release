#! /bin/sh
sed -i '/apt-get update/d' /root/cf_nise_installer/nise_bosh/bin/init
sed -i '/exit 1/d' /root/cf_nise_installer/nise_bosh/bin/init
# sed -i 's/peer-heartbeat-timeout/peer-heartbeat-interval/g' /root/cf_nise_installer/cf-release/jobs/etcd/templates/etcd_ctl.erb