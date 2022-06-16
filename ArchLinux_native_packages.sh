#!/usr/bin/env bash
# Script description
##  Step one - we need to obtain all PKGBUILDs for native building ##
BUIlDDIR=/home/$USER/zstd

## Create location for compiling and cd into it ##
mkdir ${BUIlDDIR}
cd ${BUIlDDIR}

## List PKGBUILDs to compile ##
#Example: _packages="core/zstd"
_packages=""

## Get the packages ##
paru -G ${_packages}

## Building the packages ##
files=$(find . -name "PKGBUILD")
for f in $files
do
PKGREL=$(grep -o 'pkgrel=[0-9]*' $f | grep -o '[0-9]*')
NEW_PKGREL=$(echo "$PKGREL + 0.1" | bc)
sed -i "s/pkgrel=[0-9]*/pkgrel=$NEW_PKGREL/" $f
done

for f in $files
do
  d=$(dirname $f)
  cd $d
  updpkgsums
  makepkg --printsrcinfo > .SRCINFO
  makepkg -s --skipinteg
  cd ..
done
