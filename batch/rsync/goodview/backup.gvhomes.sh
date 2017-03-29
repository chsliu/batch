#/bin/bash

DIR=$(readlink -e $0)
DP0=$(dirname "$DIR")
pname=$(basename "$DP0")
pname_fixed=${pname// /\\ }
TODAY=$(date +"%Y-%m-%d")
MONTH=$(date +"%Y-%m")

options="-avz --progress --chmod=ugo=rwX --no-owner --no-group --omit-dir-times --delete --delete-excluded --exclude-from ./ignores.txt --backup --backup-dir=/$(whoami)/recycle/$MONTH/$TODAY/$pname_fixed"

src=.

dst="rsync://rsync@goodview.com.tw/homes/$(whoami)/$pname"


pushd "$DP0"

export RSYNC_PASSWORD=rsync

echo rsync $options $src "$dst"
rsync $options $src "$dst"

popd

sleep 10
