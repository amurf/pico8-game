#!/bin/sh

SRC_FILES=src/lua/*.lua

echo * Rebuilding cart
./build.pl
watchman-make -p $SRC_FILES --run ./build.pl
