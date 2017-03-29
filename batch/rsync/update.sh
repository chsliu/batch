#/bin/bash

DIR=$(readlink -e $0)
DP0=$(dirname "$DIR")
pname=$(basename "$DP0")

options="-avz --progress --chmod=ugo=rwX --no-owner --no-group --omit-dir-times --delete --exclude-from ./ignores.txt"

src="rsync://sitahome.ddns.net/NetBackup/rsync/$pname"

dst=..


pushd "$DP0"

echo rsync $options "$src" $dst
rsync $options "$src" $dst

popd

