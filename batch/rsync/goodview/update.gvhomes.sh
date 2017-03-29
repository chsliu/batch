#/bin/bash

DIR=$(readlink -e $0)
DP0=$(dirname "$DIR")
pname=$(basename "$DP0")

options="-avz --progress --chmod=ugo=rwX --no-owner --no-group --omit-dir-times --delete --exclude-from ./ignores.txt"

src="rsync://rsync@goodview.com.tw/homes/$(whoami)/$pname"

dst=..


pushd "$DP0"

export RSYNC_PASSWORD=rsync

echo rsync $options "$src" $dst
rsync $options "$src" $dst

popd

