#! /bin/sh
# export INSTALLER_BRANCH=v237 ; export NISE_DOMAIN=cf-mini.example ; export NISE_PASSWORD=c1oudc0w ; source ~/.profile
sed -i '/apt-get update/d' /root/cf_nise_installer/nise_bosh/bin/init
sed -i '/exit 1/d' /root/cf_nise_installer/nise_bosh/bin/init

# change consul port to 8600 & recreate cf release
# cd /root/cf_nise_installer/cf-release
# ./scripts/update
# grep -lr "DNS: 53" ./src/consul-release/ | xargs sed -i 's/DNS: 53,/DNS: 8600,/g'
# cp -p config/final.yml config/final.yml.old

rbenv install 2.3.0
echo "2.3.0" > .ruby-version
gem install bundler bosh_cli --no-ri --no-rdoc
# bosh sync blobs

# echo "---
# final_name: cf
# min_cli_version: 1.5.0.pre.1001
# blobstore:
#   provider: local
#   options:
#     blobstore_path: /root/cf_nise_installer/cf-release/.blobs" > config/final.yml
# 
# echo "---
# blobstore_secret: 'does-not-matter'
# blobstore:
#   local:
#     blobstore_path: /root/cf_nise_installer/cf-release/.blobs" > config/private.yml

# cf_version=`echo ${INSTALLER_BRANCH} | sed 's/^v//' | sed 's/^V//'`
# mv releases/cf-${cf_version}.yml releases/cf-${cf_version}.yml.old
# mv releases/index.yml releases/index.yml.old
# mv .final_builds/license/index.yml .final_builds/license/index.yml.old

#### bosh init release cf
#### echo yes | bosh create release --name cf --version ${cf_version} --force

# echo $INSTALLER_BRANCH
# export INSTALLER_BRANCH=v237 ; export NISE_DOMAIN=cf-mini.example ; export NISE_PASSWORD=c1oudc0w
# source ~/.profile
# rm -rf .final_builds
# echo yes | bosh create release --name cf --version ${cf_version} --final --force
# rbenv uninstall 2.3.0


## TEST ##

cd /root/cf_nise_installer/cf-release/src/consul-release
git submodule update --init
grep -lr "DNS: 53" . | xargs sed -i 's/DNS: 53,/DNS: 8600,/g'
cp -p config/final.yml config/final.yml.old
bosh sync blobs

echo "---
final_name: consul
min_cli_version: 1.5.0.pre.1001
blobstore:
  provider: local
  options:
    blobstore_path: /root/cf_nise_installer/cf-release/src/consul-release/.blobs" > config/final.yml

echo "---
blobstore_secret: 'does-not-matter'
blobstore:
  local:
    blobstore_path: /root/cf_nise_installer/cf-release/src/consul-release/.blobs" > config/private.yml

mv releases/consul/consul-80.yml releases/consul/consul-80.yml.old
mv releases/consul/index.yml releases/consul/index.yml.old
rm -rf .final_builds
# source ~/.profile
# echo yes | bosh create release --name consul --version 80 --final --force
# rbenv uninstall 2.3.0
