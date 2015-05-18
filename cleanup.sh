#!/bin/sh
apt-get clean
rm -rf /var/lib/apt/lists/* 
rm -rf /var/vcap/data/packages/buildpack_go
rm -rf /var/vcap/data/packages/buildpack_java
rm -rf /var/vcap/data/packages/buildpack_php
rm -rf /var/vcap/data/packages/buildpack_python
# ? rm -rf /root/cf_nise_installer/cf-release/.final_builds
