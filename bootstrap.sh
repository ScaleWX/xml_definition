#!/bin/sh
autoreconf --install --force || exit 1
echo "Please run ./configure, make and make install."
