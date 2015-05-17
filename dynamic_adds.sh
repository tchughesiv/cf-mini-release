#! /bin/sh

# NISE_IP_ADDRESS=${NISE_IP_ADDRESS:-`ip addr | grep 'inet .*global' | cut -f 6 -d ' ' | cut -f1 -d '/' | head -n 1`}
sed -i 's/buildpack_java/buildpack_java_offline/g' /root/cf_nise_installer/manifests/template.yml
sed -i 's/^    hm9000_noop: false/    hm9000_noop: false\n    default_app_memory: 512\n    default_app_disk_in_mb: 512/g' /root/cf_nise_installer/manifests/template.yml
sed -i 's/#{ip_address}\/16/0.0.0.0\/0/g' /root/cf_nise_installer/nise_bosh/lib/nise_bosh/builder.rb
# sed -i 's/#{ip_address}/0.0.0.0/g' /root/cf_nise_installer/nise_bosh/lib/nise_bosh/builder.rb
# sed -i 's/= ip_address/= 0.0.0.0/g' /root/cf_nise_installer/nise_bosh/lib/nise_bosh/builder.rb
# echo 'sed -i "s/${NISE_IP_ADDRESS}/0.0.0.0/g" manifests/deploy.yml' >> /root/cf_nise_installer/scripts/generate_deploy_manifest.sh
# sed -i "s/.\/scripts\/clone_cf_release.sh/sed -i 's\/\${NISE_IP_ADDRESS}\/0.0.0.0\/g' \/root\/cf_nise_installer\/scripts\/install_cf_release.sh\n.\/scripts\/clone_cf_release.sh/g" /root/cf_nise_installer/scripts/install.sh
echo ${NISE_IP_ADDRESS} > /root/PRIOR_NISE_IP_ADDRESS
sed -i '/NISE_IP_ADDRESS=/d' /root/cf_nise_installer/scripts/install_cf_release.sh
sed -i '/NISE_IP_ADDRESS=/d' /root/cf_nise_installer/scripts/generate_deploy_manifest.sh
sed -i '/install_ruby.sh/d' /root/cf_nise_installer/scripts/install.sh
sed -i '/apt-get update/d' /root/cf_nise_installer/scripts/install.sh
