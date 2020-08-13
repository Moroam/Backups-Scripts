#!/bin/bash

# Copy backups to external data storage

# Parent backup directory
#backup_parent_dir="/home/backups"
backup_parent_dir=$1

# Log file
#LOGFILE="/home/backups/backup.log"
LOGFILE=$2

# External storage for backups
#mount_backup_dir="/mnt/backups"
mount_backup_dir=$3

# Create backup directory and set permissions
backup_date=`date +%Y_%m_%d`
backup_dir="${backup_parent_dir}/${backup_date}"

echo "# `date +%Y%m%d-%H:%M` START copy backup ${backup_dir} to ${mount_backup_dir}" | tee -a $LOGFILE

cp -r ${backup_dir} ${mount_backup_dir} | tee -a $LOGFILE
