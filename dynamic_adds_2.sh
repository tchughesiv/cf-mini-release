#! /bin/sh
sed -i '/apt-get update/d' /root/cf_nise_installer/nise_bosh/bin/init
sed -i '/exit 1/d' /root/cf_nise_installer/nise_bosh/bin/init

# change consul port to 8600 & build cf release
cd /root/cf_nise_installer/cf-release
./scripts/update
grep -lr "DNS: 53" ./src/consul-release/ | xargs sed -i 's/DNS: 53,/DNS: 8600,/g'
cp -p config/final.yml config/final.yml.old

source ~/.profile
rbenv install 2.3.0
echo "2.3.0" > .ruby-version
gem install bundler bosh_cli --no-ri --no-rdoc
bosh sync blobs
rm -rf .final_builds

echo "---
final_name: cf
min_cli_version: 1.5.0.pre.1001
blobstore:
  provider: local
  options:
    blobstore_path: /root/cf_nise_installer/cf-release/blobs" > config/final.yml

echo "---
blobstore_secret: 'does-not-matter'
blobstore:
  local:
    blobstore_path: /root/cf_nise_installer/cf-release/blobs" > config/private.yml

cf_version=`echo ${INSTALLER_BRANCH} | sed 's/^v//' | sed 's/^V//'`
mv releases/cf-${cf_version}.yml releases/cf-${cf_version}.yml.old
mv releases/index.yml releases/index.yml.old
tac releases/index.yml.old | sed "/version: '${cf_version}'/{N;d;}" | tac > releases/index.yml
echo yes | bosh create release --name cf --version ${cf_version} --final --force