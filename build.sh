#!/bin/bash

set -e

INSTALL_PATH=usr/share/skeleton-debian

PACKAGE_NAME=$(grep Package "./DEBIAN/control" |cut -d: -f 2| xargs echo)
PACKAGE_VERSION=$(grep Version "./DEBIAN/control" |cut -d: -f 2| xargs echo)
PACKAGE_ARCH=$(grep Architecture "./DEBIAN/control" |cut -d: -f 2| xargs echo)

TEMP=$(mktemp -d)
mkdir -p "$TEMP/$PACKAGE_NAME/$INSTALL_PATH"

cp -r DEBIAN "$TEMP/$PACKAGE_NAME"

#cp <files to include in package> "$TEMP/$PACKAGE_NAME/$INSTALL_PATH"

dpkg-deb -b "$TEMP/$PACKAGE_NAME" "${PACKAGE_NAME}_${PACKAGE_VERSION}_${PACKAGE_ARCH}.deb"

rm -rf "$TEMP"
