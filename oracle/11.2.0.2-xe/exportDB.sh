#!/bin/sh
#--------------------------------------------------------------------------------------------------------------
# Script to export backup from database
#
mkdir -p /u01/export_bkp && chown oracle:dba /u01/export_bkp

# create export dump folder and permissions in database
sqlplus sys/oracle@//localhost:1521/EE.oracle.docker as sysdba << EOF
    create directory EXP_DUMP as '/u01/export_bkp';
    grant read, write on directory EXP_DUMP to rm;
    grant exp_full_database to rm;
    exit;
EOF

# export dump
cdate=$(date '+%Y%m%d%H%M%S')
expdp rm/rm@localhost:1521/EE.oracle.docker directory=EXP_DUMP dumpfile=$cdate.dmp logfile=$cdate.log schemas=RM

exit $?
