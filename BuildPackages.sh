#!/bin/bash

dpkg-scanpackages -m ./Files /dev/null > Packages

gzip -cf Packages > Packages.gz
xz -9fkev Packages > Packages.xz
bzip2 -cf Packages > Packages.bz2

git add -A
git commit -m "update VolButtonBrightness 1.0.2"
git push -u origin master