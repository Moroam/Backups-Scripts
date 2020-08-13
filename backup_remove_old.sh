#!/bin/bash

# Script for deleting old backups

# Parent backup directory
#backup_parent_dir="/home/backups"
backup_parent_dir=$1

# Log file
#LOGFILE="/home/backups/backup.log"
LOGFILE=$2

# How long (number of days) to store backups
#LIMITTIME="+2"
LIMITTIME=$3

echo "# `date +%Y%m%d-%H:%M` START delete old backups"  | tee -a $LOGFILE

find $backup_parent_dir -type d -name "*_*_*" -ctime $LIMITTIME | tee -a $LOGFILE
find $backup_parent_dir -type d -name "*_*_*" -ctime $LIMITTIME -exec rm -r -f {} \;
