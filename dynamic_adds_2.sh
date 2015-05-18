#! /bin/sh

#sed -i 's/#{ip_address}\/16/0.0.0.0\/0/g' /root/cf_nise_installer/nise_bosh/lib/nise_bosh/builder.rb
#sed -i 's/#{ip_address} - #{ip_address}/0.0.0.0/g' /root/cf_nise_installer/nise_bosh/lib/nise_bosh/builder.rb
# sed -i 's/= ip_address/= 0.0.0.0/g' /root/cf_nise_installer/nise_bosh/lib/nise_bosh/builder.rb
sed -i '/apt-get update/d' /root/cf_nise_installer/nise_bosh/bin/init
