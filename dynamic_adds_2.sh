#! /bin/sh
sed -i '/apt-get update/d' /root/cf_nise_installer/nise_bosh/bin/init
sed -i '/exit 1/d' /root/cf_nise_installer/nise_bosh/bin/init

# change consul port to 8600
cd /root/cf_nise_installer/cf-release
./scripts/update
grep -lr "DNS: 53" ./src/consul-release/ | xargs sed -i 's/DNS: 53,/DNS: 8600,/g'
cp -p config/final.yml config/final.yml.old

source ~/.profile
rbenv install 2.3.0
echo "2.3.0" > .ruby-version
rbenv global 2.3.0
gem install bundler bosh_cli --no-ri --no-rdoc
bundle install --deployment
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

mv releases/cf-237.yml releases/cf-237.yml.old
mv releases/index.yml releases/index.yml.old
tac releases/index.yml.old | sed "/version: '237'/{N;d;}" | tac > releases/index.yml
echo yes | bosh create release --name cf --version 237 --final --force

# NISE_IP_ADDRESS=${NISE_IP_ADDRESS:-`ip addr | grep 'inet .*global' | cut -f 6 -d ' ' | cut -f1 -d '/' | head -n 1`}
# sudo env PATH=$PATH bundle exec /root/cf_nise_installer/nise_bosh/bin/nise-bosh --keep-monit-files -p -y /root/cf_nise_installer/cf-release confab -n ${NISE_IP_ADDRESS}
