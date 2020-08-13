#!/bin/bash

# Script to backup directory with WEB sites

# Parent backup directory
#backup_parent_dir="/home/backups"
backup_parent_dir=$1

# Log file
#LOGFILE="/home/backups/backup.log"
LOGFILE=$2

# WEB sites directory
#source_dir="/web"
source_dir=$3

# Exclude media file storage directory
#exclude_dir="/web/site.my/file_storage"
exclude_dir=$4

echo "# `date +%Y%m%d-%H:%M` START backup  WEB"  | tee -a $LOGFILE

# Create backup directory and set permissions
backup_date=`date +%Y_%m_%d`
backup_dir="${backup_parent_dir}/${backup_date}"

mkdir -p "${backup_dir}"
chmod 700 "${backup_dir}"

tar --exclude="${exclude_dir}" -zcf "${backup_dir}/web.tar.gz" "${source_dir}"
exitcode=$?
if [ "$exitcode" != "1" ] && [ "$exitcode" != "0" ];
then
 echo "Backup WEB is failed" | tee -a $LOGFILE
fi
chmod 600 "${backup_dir}/web.tar.gz"
