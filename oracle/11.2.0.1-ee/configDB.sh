#!/bin/bash
#--------------------------------------------------------------------------------------------------------------
#*  Script to change database character set to WE8MSWIN1252
#       Run only after database is online
#
#
sqlplus sys/oracle as sysdba << EOF
    alter system enable restricted session;
    alter database character set internal_use WE8MSWIN1252;
    alter system disable restricted session;
    exit;
EOF
