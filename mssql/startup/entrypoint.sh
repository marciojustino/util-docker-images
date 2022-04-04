#!/bin/bash
#start SQL Server, start the script to restore the DB
/var/opt/startup/init.sh & /opt/mssql/bin/sqlservr
SQLSERVER_PID=$!
