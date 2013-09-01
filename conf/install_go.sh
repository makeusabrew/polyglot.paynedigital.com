#!/usr/bin/env bash

GOFILE=go1.1.2.linux-amd64.tar.gz
wget http://go.googlecode.com/files/$GOFILE
tar -C /usr/local -xzf $GOFILE
