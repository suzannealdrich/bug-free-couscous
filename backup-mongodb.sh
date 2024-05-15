#!/bin/bash
LOGFILE="/var/log/mongodb-backup.log"
exec 3>&1 1>"$LOGFILE" 2>&1
trap "echo 'ERROR: An error occurred during execution, check log $LOGFILE for details.' >&3" ERR
trap '{ set +x; } 2>/dev/null; echo -n "[$(date -Is)]  "; set -x' DEBUG

TIMESTAMP=$(date +"%F-%H%M%S")
BACKUP_DIR="/backup/$TIMESTAMP"

echo "creating a temporary backup directory" >&3
mkdir $BACKUP_DIR

echo "performing a database dump into the backup directory" >&3

mongodump --out $BACKUP_DIR --authenticationDatabase admin -u myUserAdmin -p oX6v8-MC-NvDcudKRUdNyX

echo "copying database dump into s3" >&3
aws s3 cp $BACKUP_DIR s3://hire.suzanne.immediately/$TIMESTAMP --recursive

echo "removing temporary backup directory and contents" >&3
rm -rf $BACKUP_DIR