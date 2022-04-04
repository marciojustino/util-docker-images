#!/bin/bash
#--------------------------------------------------------------------------------------------------------------
#*  Script to change database character set to WE8ISO8859P1
#       Run only after database is online
#
#
su -p oracle -c "sqlplus -s / as sysdba" << EOF
    alter system enable restricted session;
    alter database character set internal_use WE8ISO8859P1;
    alter system disable restricted session;
    exit;
EOF
