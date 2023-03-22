#!/bin/bash
set -ex

BUILD_ROOT=$(mktemp -d)
NAME=mod-event-kafka
SUB_VERSION=$(git rev-list --count HEAD)
VERSION=3.0.13-${SUB_VERSION}
ARCH=$(dpkg --print-architecture)

make
make install

cp -r distribution/debian/* $BUILD_ROOT/

#mkdir -p $BUILD_ROOT/usr/local/lib/
#mkdir -p $BUILD_ROOT/usr/lib/freeswitch/mod
#mkdir -p $BUILD_ROOT/etc/freeswitch/autoload_configs/
mkdir -p  $BUILD_ROOT/usr/lib/freeswitch/mod/

#cp /etc/freeswitch/autoload_configs/event_kafka.conf.xml  $BUILD_ROOT/etc/freeswitch/autoload_configs/event_kafka.conf.xml
#cp /usr/lib/freeswitch/mod/mod_event_kafka.so  $BUILD_ROOT/usr/lib/freeswitch/mod/mod_event_kafka.so
cp /usr/local/freeswitch/mod/mod_event_kafka.so $BUILD_ROOT/usr/lib/freeswitch/mod/mod_event_kafka.so

sed -i "s/_NAME_/$NAME/g" $BUILD_ROOT/DEBIAN/control
sed -i "s/_VERSION_/$VERSION/g" $BUILD_ROOT/DEBIAN/control
sed -i "s/_ARCH_/$ARCH/g" $BUILD_ROOT/DEBIAN/control
dpkg-deb --build $BUILD_ROOT mod-event-kafka_${VERSION}_${ARCH}.deb

rm -rf $BUILD_ROOT
