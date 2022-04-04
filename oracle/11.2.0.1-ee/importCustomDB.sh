#!/bin/sh
#--------------------------------------------------------------------------------------------------------------
# Script to detect and import database using right tool (imp or impdp)
#
BACKUP_FILE="/u01/app/oracle/oradata/EE/MYBACKUP.dmp"
LOG_FILE="/u01/app/oracle/oradata/EE/imp_MYBACKUP.log"

# Check backup file header to use impd or impdp tool
head=$(strings ${BACKUP_FILE} | head -n 1)
if [[ "$head" =~ .*"EXPORT:".* ]]; then
    if ! [ -f $BACKUP_FILE ]; then
        echo Backup file not found
        exit 1
    fi
    imp rm/rm@//localhost:1521/EE.oracle.docker file=$BACKUP_FILE log=$LOG_FILE fromuser=rm touser=rm > /dev/null
else
sqlplus sys/oracle@//localhost:1521/EE.oracle.docker as sysdba << EOF
    CREATE OR REPLACE DIRECTORY baseoracle AS '/u01/app/oracle/oradata/EE';
    GRANT READ, WRITE ON DIRECTORY baseoracle TO rm;
    execute sys.dbms_metadata_util.load_stylesheets;
    exit;
EOF
impdp rm/rm@//localhost:1521/EE.oracle.docker schemas=RM directory=baseoracle dumpfile=MYBACKUP.dmp logfile=impdp_MYBACKUP.log > /dev/null
fi

exit $?
