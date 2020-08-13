#!/bin/bash

# Script for copy (rsync) file storage

# External storage for backups
#mnt_backup_dir="/mnt/backups/web_archive"
mnt_backup_dir=$1

# Log file
#LOGFILE="/home/backups/backup.log"
LOGFILE=$2

# Media File storage directory
#media_file_dir="/web/site.my/file_sorage"
media_file_dir=$3

echo "# `date +%Y%m%d-%H:%M` START copy ${media_file_dir} to ${mnt_backup_dir}" | tee -a $LOGFILE

sudo rsync -av ${media_file_dir} ${mnt_backup_dir} #| tee -a $LOGFILE

echo "# `date +%Y%m%d-%H:%M` STOP copy | tee -a $LOGFILE
