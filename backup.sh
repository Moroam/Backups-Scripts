#!/bin/bash

# Parent backup directory
backup_parent_dir="/home/backups"
# Log file
LOGFILE="/home/backups/backup.log"
# External storage for backups
mnt_backup_dir="/mnt/backups"
mnt_backup_dir_mysql="/mnt/backups/mysql"
mnt_backup_dir_media="/mnt/backups/web_media"
# How long (number of days) to store backups
LIMITTIME="+2"

# MySQL settings
mysql_user="backup_user"
mysql_password="backup_user_password"
# MySQL database file directory
mysql_dir="/home/mysql"

# WEB sites directory
web_dir="/web"
# WEB site Media file storage directory
media_file_dir="/web/site.my/archive"
# WEB site TMP Directory
TMPDIR="/web/site.my/tmp"

./backup_remove_old.sh  $backup_parent_dir    $LOGFILE $LIMITTIME
./backup_mysql.sh       $backup_parent_dir    $LOGFILE $mysql_user $mysql_password
./backup_mysql_dir.sh   $mnt_backup_dir_mysql $LOGFILE $mysql_dir
./clear_tmp.sh          $TMPDIR               $LOGFILE
./backup_web.sh         $backup_parent_dir    $LOGFILE $web_dir $media_file_dir
./backup_web_archive.sh $mnt_backup_dir_media $LOGFILE $media_file_dir
./backup_copy.sh        $backup_parent_dir    $LOGFILE $mnt_backup_dir
