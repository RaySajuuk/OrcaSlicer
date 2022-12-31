#!/bin/sh

WD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $WD/deps
mkdir -p build
cd build
DEPS=$PWD/BambuStudio_dep
mkdir -p $DEPS
cmake ../ -DDESTDIR="$DEPS" -DOPENSSL_ARCH="darwin64-$(uname -m)-cc" -DCMAKE_BUILD_TYPE=Release
cmake --build . --config Release --target ALL_BUILD 

cd $WD
mkdir -p build
cd build
cmake .. -GXcode -DBBL_RELEASE_TO_PUBLIC=1 -DCMAKE_PREFIX_PATH="$DEPS/usr/local" -DCMAKE_INSTALL_PREFIX="$PWD/BambuStudio-SoftFever" -DCMAKE_BUILD_TYPE=Release -DCMAKE_MACOSX_RPATH=ON -DCMAKE_INSTALL_RPATH="$DEPS/usr/local" -DCMAKE_MACOSX_BUNDLE=ON
cmake --build . --config Release --target ALL_BUILD 
# cmake --build . --target install --config Release
# cd BambuStudio-SoftFever
# cp -r bin/BambuStudio.app/Contents/MacOS BambuStudio.app/Contents
# cp -r bin/BambuStudio.app/Contents/Info.plist BambuStudio.app/Contents/