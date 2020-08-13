#!/bin/bash

# Simple script to backup MySQL databases

# Parent backup directory
#backup_parent_dir="/home/backups"
backup_parent_dir=$1

# Log file
#LOGFILE="/home/backups/backup.log"
LOGFILE=$2

# MySQL settings
#mysql_user="backup_user"
#mysql_password="backup_user_password"
mysql_user=$3
mysql_password=$4

echo "# `date +%Y%m%d-%H:%M` START backup  MySQL"  | tee -a $LOGFILE

# Check MySQL password
echo exit | mysql --user=${mysql_user} --password=${mysql_password} -B 2>/dev/null
if [ "$?" -gt 0 ]; then
    echo "MySQL ${mysql_user} password incorrect"  | tee -a $LOGFILE
    exit 1
fi

# Create backup directory and set permissions
backup_date=`date +%Y_%m_%d`
backup_dir="${backup_parent_dir}/${backup_date}"
echo "Backup directory: ${backup_dir}"
mkdir -p "${backup_dir}"
chmod 700 "${backup_dir}"

# Get MySQL databases
mysql_databases=`echo 'show databases' | mysql --user=${mysql_user} --password=${mysql_password} -B | egrep -v '(information_schema|mysql|sys|performance_schema)' | sed /^Database$/d`

# Backup and compress each database with DATA
additional_mysqldump_params="--disable-keys --extended-insert --single-transaction"
for database in $mysql_databases
do
    echo "Creating backup of \"${database}\" database"
    mysqldump ${additional_mysqldump_params} --user=${mysql_user} --password=${mysql_password} ${database} | gzip > "${backup_dir}/${database}.gz"
    if [ ${PIPESTATUS[0]} != "0" ];
    then
	   echo "Backup database is failed ${database}" | tee -a $LOGFILE
    else
	   echo "Backup database is DONE ${database}" | tee -a $LOGFILE
    fi
    chmod 600 "${backup_dir}/${database}.gz"
done

# Backup and compress each database only ROUTINES
additional_mysqldump_params="--routines --triggers --events --no-data --single-transaction"
for database in $mysql_databases
do
    echo "Creating backup of \"${database}\" database"
    mysqldump ${additional_mysqldump_params} --user=${mysql_user} --password=${mysql_password} ${database} | sed -e 's/DEFINER[ ]*=[ ]*[^*]*\*/\*/' | sed -e 's/DEFINER[ ]*=[ ]*[^*]*PROCEDURE/PROCEDURE/' | sed -e 's/DEFINER[ ]*=[ ]*[^*]*FUNCTION/FUNCTION/' | gzip > "${backup_dir}/s_${database}.gz"
    if [ ${PIPESTATUS[0]} != "0" ];
    then
	   echo "Backup database is failed ${database}" | tee -a $LOGFILE
    else
	   echo "Backup database is DONE ${database}" | tee -a $LOGFILE
    fi
    chmod 600 "${backup_dir}/s_${database}.gz"
done
