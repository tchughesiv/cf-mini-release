#!/bin/sh
apt-get clean
rm -rf /var/lib/apt/lists/* 
rm -rf /var/vcap/data/packages/buildpack_go/c647d65201f25e34bcc304898afe43c82104d950/go_buildpack-cached-v1.2.0.zip
rm -rf /var/vcap/data/packages/buildpack_java/27d3334505188b901ec447e4e2b846a2ae34edb7/java-buildpack-v2.7.1.zip
rm -rf /var/vcap/data/packages/buildpack_php/60fb983e430ab8de7fb647cba59954f8d0c4b9c9/php_buildpack-offline-v3.1.0.zip
rm -rf /var/vcap/data/packages/buildpack_python/076c11da464aa50911e1744b39e95522a00e1f48/python_buildpack-cached-v1.2.0.zip
find ~/cf_nise_installer/cf-release/.final_builds/packages/*/ -type f -iname "*.tgz" -print0 | xargs -0 -I {} truncate {} --size 0
