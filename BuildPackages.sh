#!/bin/bash

dpkg-scanpackages -m ./Files /dev/null > Packages

gzip -cf Packages > Packages.gz
xz -9fkev Packages > Packages.xz
bzip2 -cf Packages > Packages.bz2

git add -A
git commit -m "Update IGNoSwipeBacks"
git push -u origin master