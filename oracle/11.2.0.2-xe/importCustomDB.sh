#!/bin/bash
#--------------------------------------------------------------------------------------------------------------
# Script to detect and import database using right tool (imp or impdp)
#
BACKUP_FILE="/opt/oracle/oradata/MYBACKUP/MYBACKUP.dmp"
LOG_FILE="/opt/oracle/oradata/MYBACKUP/imp_MYBACKUP.log"

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
    CREATE OR REPLACE DIRECTORY baseoracle AS '/opt/oracle/oradata/MYBACKUP';
    GRANT READ, WRITE ON DIRECTORY baseoracle TO rm;
    exit;
EOF
impdp rm/rm@//localhost:1521/EE.oracle.docker schemas=RM directory=baseoracle dumpfile=MYBACKUP.dmp logfile=impdp_MYBACKUP.log > /dev/null
fi

exit $?
