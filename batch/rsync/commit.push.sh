#/bin/bash

DIR=$(readlink -e $0)
DP0=$(dirname "$DIR")
pname=$(basename "$DP0")
pname_fixed=${pname// /\\ }
TODAY=$(date +"%Y-%m-%d")
MONTH=$(date +"%Y-%m")

options="-avz --progress --chmod=ugo=rwX --no-owner --no-group --omit-dir-times --delete --delete-excluded --exclude-from ./ignores.txt --backup --backup-dir=/recycle/$MONTH/$TODAY/rsync/$pname_fixed"

src=.

dst="rsync://sitahome.ddns.net/NetBackup/rsync/$pname"


pushd "$DP0"

echo rsync $options $src "$dst"
rsync $options $src "$dst"

popd

sleep 10
