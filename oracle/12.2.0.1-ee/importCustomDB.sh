#!/bin/sh
#--------------------------------------------------------------------------------------------------------------
# Script to detect and import database using right tool (imp or impdp)
#
BACKUP_FILE="/opt/oracle/oradata/ORCLCDB/ORCLPDB1/MYBACKUP.dmp"
LOG_FILE="/opt/oracle/oradata/ORCLCDB/ORCLPDB1/imp_MYBACKUP.log"

# Check backup file header to use impd or impdp tool
head=$(strings ${BACKUP_FILE} | head -n 1)
if [[ "$head" =~ .*"EXPORT:".* ]]; then
    if ! [ -f $BACKUP_FILE ]; then
        echo Backup file not found
        exit 1
    fi
    imp rm/rm@//localhost:1521/ORCLPDB1 file=$BACKUP_FILE log=$LOG_FILE fromuser=rm touser=rm > /dev/null
else
sqlplus sys/T0tvsDev@//localhost:1521/ORCLPDB1 as sysdba << EOF
    CREATE OR REPLACE DIRECTORY baseoracle AS '/opt/oracle/oradata/ORCLCDB/ORCLPDB1';
    GRANT READ, WRITE ON DIRECTORY baseoracle TO rm;
    execute sys.dbms_metadata_util.load_stylesheets;
    exit;
EOF
impdp rm/rm@//localhost:1521/ORCLPDB1 schemas=RM directory=baseoracle dumpfile=MYBACKUP.dmp logfile=impdp_MYBACKUP.log > /dev/null
fi

exit $?
