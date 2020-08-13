#!/bin/bash

# Simple script to backup MySQL directory

# External storage for backups
#mnt_backup_dir="/mnt/backups/mysql"
mnt_backup_dir=$1

# Log file
#LOGFILE="/home/backups/backup.log"
LOGFILE=$2

# MySQL database file directory
#mysql_dir="/home/mysql"
mysql_dir=$3

echo "# `date +%Y%m%d-%H:%M` START copy ${mysql_dir} to ${mnt_backup_dir}" | tee -a $LOGFILE

systemctl stop mysqld | tee -a $LOGFILE
sudo rsync -av ${mysql_dir} ${mnt_backup_dir} | tee -a $LOGFILE
systemctl start mysqld | tee -a $LOGFILE

sudo rsync -av /etc/my.cnf   ${mnt_backup_dir} | tee -a $LOGFILE
# For MySQL 8.0
sudo rsync -av /etc/my.cnf.d   ${mnt_backup_dir} | tee -a $LOGFILE

echo "# `date +%Y%m%d-%H:%M` STOP copy" | tee -a $LOGFILE
