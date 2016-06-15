#!/bin/sh
apt-get clean
rm -rf /var/lib/apt/lists/* 
# find /var/vcap/data/packages/buildpack_go -type f -iname "*.zip" | xargs rm -f ;
# find /var/vcap/data/packages/buildpack_java -type f -iname "*.zip" | xargs rm -f ;
# find /var/vcap/data/packages/buildpack_php -type f -iname "*.zip" | xargs rm -f ;
# find /var/vcap/data/packages/buildpack_python -type f -iname "*.zip" | xargs rm -f ;
find /root/cf_nise_installer/cf-release/.final_builds/packages/*/ -type f -iname "*.tgz" -print0 | xargs -0 -I {} truncate {} --size 0
find /root/cf_nise_installer/cf-release/.blobs/ -type f -print0 | xargs -0 -I {} truncate {} --size 0
# rm -rf /root/cf_nise_installer/cf-release/src/*
