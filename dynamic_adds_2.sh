#!/bin/bash -ex
sed -i '/apt-get update/d' /root/cf_nise_installer/nise_bosh/bin/init
sed -i '/exit 1/d' /root/cf_nise_installer/nise_bosh/bin/init

# forced fix for already merged code  https://github.com/nttlabs/nise_bosh/pull/30
sed -i 's/\["dev_name"\] : ""/.fetch("dev_name", "") : ""/g' /root/cf_nise_installer/nise_bosh/lib/nise_bosh/builder.rb

# change consul port to 8600 & recreate cf release
cd /root/cf_nise_installer/cf-release
./scripts/update
rbenv install 2.3.0
echo "2.3.0" > .ruby-version
gem install bundler bosh_cli --no-ri --no-rdoc

grep -lr "DNS: 53" ./src/consul-release/ | xargs sed -i 's/DNS: 53,/DNS: 8600,/g'
cp -p config/final.yml ./final.yml.old
bosh sync blobs

echo "---
final_name: cf
min_cli_version: 1.5.0.pre.1001
blobstore:
  provider: local
  options:
    blobstore_path: /root/cf_nise_installer/cf-release/.blobs" > config/final.yml

echo "---
blobstore_secret: 'does-not-matter'
blobstore:
  local:
    blobstore_path: /root/cf_nise_installer/cf-release/.blobs" > config/private.yml

cf_version=`echo ${INSTALLER_BRANCH} | sed 's/^v//' | sed 's/^V//'`
mv releases/cf-${cf_version}.yml ./cf-${cf_version}.yml.old
mv releases/index.yml ./index.yml.old
rm -rf .final_builds
echo yes | bosh create release --name cf --version ${cf_version} --final --force
echo y | rbenv uninstall 2.3.0