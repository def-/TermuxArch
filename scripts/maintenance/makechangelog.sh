#!/bin/sh -e 
# Copyright 2017 by SDRausty. All rights reserved.
# Website for this project at https://sdrausty.github.io/TermuxArch
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You 
#############################################################################

cp setupTermuxArch.sh ../..
md5sum *sh > termuxarchchecksum.md5 
cd ../..
bsdtar -czv -f setupTermuxArch.tar.gz --strip-components 2 scripts/files/*
rm scripts/files/termuxarchchecksum.md5
md5sum setupTermuxArch.tar.gz > setupTermuxArch.md5
