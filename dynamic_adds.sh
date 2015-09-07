#! /bin/sh
NISE_IP_ADDRESS=${NISE_IP_ADDRESS:-`ip addr | grep 'inet .*global' | cut -f 6 -d ' ' | cut -f1 -d '/' | head -n 1`}
echo ${NISE_IP_ADDRESS} > /root/PRIOR_NISE_IP_ADDRESS
sed -i 's/buildpack_java/buildpack_java_offline\n      - name: staticfile_buildpack\n        package: buildpack_staticfile\n      - name: binary_buildpack\n        package: buildpack_binary/g' /root/cf_nise_installer/manifests/template.yml
sed -i 's/^    hm9000_noop: false/    hm9000_noop: false\n    default_app_memory: 512\n    default_app_disk_in_mb: 512/g' /root/cf_nise_installer/manifests/template.yml
sed -i 's/disk_quota_enabled: true/disk_quota_enabled: false/g' /root/cf_nise_installer/manifests/template.yml
sed -i 's/zone: default/zone: z1/g' /root/cf_nise_installer/manifests/template.yml
# sed -i '/- admin/ s/$/,uaa.admin,password.write/' /root/cf_nise_installer/manifests/template.yml
sed -i 's/debug2/info/g' /root/cf_nise_installer/manifests/template.yml
sed -i '/consul_agent/d' /root/cf_nise_installer/manifests/template.yml
sed -i '/cc: \&cc/a \    droplets:\n      droplet_directory_key: cc-droplets\n    buildpacks:\n      buildpack_directory_key: cc-buildpacks\n    allow_app_ssh_access: false' /root/cf_nise_installer/manifests/template.yml

sed -i '/install_ruby.sh/d' /root/cf_nise_installer/scripts/install.sh
sed -i '/apt-get update/d' /root/cf_nise_installer/scripts/install.sh
sed -i '/apt-get update/d' /root/cf_nise_installer/scripts/install_environemnt.sh
sed -i 's/.\/scripts\/clone_cf_release.sh/.\/scripts\/clone_cf_release.sh\n\/root\/dynamic_adds_2.sh/g' /root/cf_nise_installer/scripts/install.sh
sed -i 's/com\/yudai\/cf_nise_installer/com\/tchughesiv\/cf_nise_installer/g' /root/cf_nise_installer/scripts/bootstrap.sh
