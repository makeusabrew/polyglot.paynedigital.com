#!/usr/bin/env bash

apt-get update
apt-get install -y python-software-properties
add-apt-repository -y ppa:nginx/stable
apt-get update
apt-get install -y nginx
