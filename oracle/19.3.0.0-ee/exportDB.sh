#!/bin/sh
#--------------------------------------------------------------------------------------------------------------
# Script to export backup from database
#
mkdir -p /opt/oracle/export_bkp && chown oracle:dba /opt/oracle/export_bkp

# create export dump folder and permissions in database
sqlplus sys/T0tvsDev@//localhost:1521/ORCLPDB1 as sysdba << EOF
    create directory EXP_DUMP as '/opt/oracle/export_bkp';
    grant read, write on directory EXP_DUMP to rm;
    grant exp_full_database to rm;
    exit;
EOF

# export dump
cdate=$(date '+%Y%m%d%H%M%S')
expdp rm/rm@//localhost:1521/ORCLPDB1 directory=EXP_DUMP dumpfile=$cdate.dmp logfile=$cdate.log schemas=RM

exit $?
