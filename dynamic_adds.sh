#! /bin/sh
NISE_IP_ADDRESS=${NISE_IP_ADDRESS:-`ip addr | grep 'inet .*global' | cut -f 6 -d ' ' | cut -f1 -d '/' | head -n 1`}
echo ${NISE_IP_ADDRESS} > /root/PRIOR_NISE_IP_ADDRESS
sed -i 's/buildpack_java/buildpack_java_offline/g' /root/cf_nise_installer/manifests/template.yml
sed -i 's/^    hm9000_noop: false/    hm9000_noop: false\n    default_app_memory: 512\n    default_app_disk_in_mb: 512/g' /root/cf_nise_installer/manifests/template.yml
sed -i 's/disk_quota_enabled: true/disk_quota_enabled: false/g' /root/cf_nise_installer/manifests/template.yml
sed -i '/install_ruby.sh/d' /root/cf_nise_installer/scripts/install.sh
# sed -i '/install_cf_release.sh/d' /root/cf_nise_installer/scripts/install.sh
sed -i '/apt-get update/d' /root/cf_nise_installer/scripts/install.sh
sed -i '/apt-get update/d' /root/cf_nise_installer/scripts/install_environemnt.sh
sed -i 's/.\/scripts\/clone_cf_release.sh/.\/scripts\/clone_cf_release.sh\n\/root\/dynamic_adds_2.sh/g' /root/cf_nise_installer/scripts/install.sh
sed -i 's/peer-heartbeat-timeout/peer-heartbeat-interval/g' /root/cf_nise_installer/cf-release/jobs/etcd/templates/etcd_ctl.erb
