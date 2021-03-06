#!/bin/bash
#
# Streams a mysqldump from the CIA server into a file locally.
# This avoids storing the backup on the CIA server itself, so we
# minimize the impact this has on our I/O quota.
#

CIA_HOST=cia@cia.vc
BACKUPDIR=/home/micah/download/cia-backups
export PATH=/opt/sbin:/opt/bin:/usr/sbin:/usr/bin:/sbin:/bin

FILE_PREFIX=`date "+cia-%F"`
DUMP_FILE=$FILE_PREFIX.dump.gz
TAR_FILE=$FILE_PREFIX.tar.gz

ssh $CIA_HOST 'database=cia; user=root; . ~/.cia_db; mysqldump -u $user --password=$passwd $database | gzip' > $BACKUPDIR/$DUMP_FILE
ssh $CIA_HOST 'cd ~/cia/data; tar cf - db | gzip' > $BACKUPDIR/$TAR_FILE                            

