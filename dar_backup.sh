#!/bin/sh

mkdir -p /volume2/backup/dar/meta && mkdir -p /volume2/backup/dar/slice && mkdir -p /volume2/backup/dar/catalog

encryption="bf:"

docker exec dar-docker-dsheyp dar_static -R /homes/jpp -s 5G -S 50M --hash md5 -z9 -an \
-Z "*.zip" -Z "*.jpg" -Z "*.jpeg" -Z "*.gz" -Z "*.gif" -Z "*.png" -Z "*.mpg" \
-Z "*.mp4" -Z "*.mp3" -Z "*.avi" -Z "*.docx" -Z "*.xlsx" -Z "*.xpi" -Z "*.7z" \
-Z "*.exe" -Z "*.msi" -Z "*.iso" \
-K $encryption -m 1k -P @eaDir \
-c /backup/slice/jpp_full -@ /backup/catalog/CAT_jpp_full \
> /var/log/disk-archiver.log  2>&1

docker exec dar-docker-dsheyp dar_static -t /backup/slice/jpp_full -K $encryption -al -E "echo '****** Opening slice %N ******'" -v \
> /volume2/backup/dar/meta/dar_slice_content.txt  2>&1

docker exec dar-docker-dsheyp dar_static -l /backup/slice/jpp_full --key $encryption \
> /volume2/backup/dar/meta/dar_content.txt  2>&1
