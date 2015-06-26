#! /bin/sh
sed -i '/apt-get update/d' /root/cf_nise_installer/nise_bosh/bin/init
sed -i 's/peer-heartbeat-timeout/peer-heartbeat-interval/g' /root/cf_nise_installer/cf-release/jobs/etcd/templates/etcd_ctl.erb
echo "wal_buffers = 16MB
checkpoint_completion_target = 0.7
checkpoint_timeout = 10m-30m
checkpoint_segments = 16
log_checkpoints = on
stats_temp_directory = /mnt/pgstats_tmp" >> /root/cf_nise_installer/cf-release/jobs/postgres/templates/postgresql.conf.erb
