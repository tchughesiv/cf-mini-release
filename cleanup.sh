#!/bin/bash -ex
apt-get clean
rm -rf /var/lib/apt/lists/* 
find /root/cf_nise_installer/cf-release/.final_builds/packages/*/ -type f -iname "*.tgz" -print0 | xargs -0 -I {} truncate {} --size 0
find /root/cf_nise_installer/cf-release/.blobs/ -type f -print0 | xargs -0 -I {} truncate {} --size 0
find /root/.bosh/cache/ -type f -print0 | xargs -0 -I {} truncate {} --size 0
# rm -rf /root/cf_nise_installer/cf-release/src/*