#!/bin/bash

# Clear temporary directory

# TMP Directory
#TMPDIR="/web/site/tmp"
TMPDIR=$1

# Log file
#LOGFILE="/home/backups/backup.log"
LOGFILE=$2

echo "# `date +%Y%m%d-%H:%M` START Clear ${TMPDIR}"  | tee -a $LOGFILE

sudo rm -rf $TMPDIR/.*
sudo rm -rf $TMPDIR/*
sudo rm -rf $TMPDIR/*.*
