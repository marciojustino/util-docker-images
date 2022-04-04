#!/bin/bash
# Wait for it to be available
echo "⏳ Waiting for MS SQL to be available..."
wait $SQLSERVER_PID

STATUS=$(/opt/mssql-tools/bin/sqlcmd -l 30 -S localhost -U sa -P ${SA_PASSWORD} -q "SET NOCOUNT ON; SELECT 1" -W -h-1)

while [ "$STATUS" != 1 ]; do
    STATUS=$(/opt/mssql-tools/bin/sqlcmd -l 30 -S localhost -U sa -P ${SA_PASSWORD} -q "SET NOCOUNT ON; SELECT 1" -W -h-1)
    sleep 3
done

# Restore backup database
if [ -d /var/opt/mssql/backups ]; then
    for backup in /var/opt/mssql/backups/*.bak ; do
        echo "⏳ Restoring backup database $backup..."
        /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P ${SA_PASSWORD} -q "RESTORE DATABASE ${DBNAME} FROM DISK = '/var/opt/mssql/backups/${DBNAME}.bak' WITH MOVE 'Exemplo_Data' TO '/var/opt/mssql/data/${DBNAME}.mdf', MOVE 'Exemplo_Log' TO '/var/opt/mssql/data/${DBNAME}.ldf'"
        BACKUP_PID=$!
        wait $BACKUP_PID
        echo "⚡ Backup $backup restored"
    done
fi

# Run every script in /scripts
if [ -d /var/opt/mssql/scripts ]; then
    for foo in /var/opt/mssql/scripts/*.sql ; do
        echo "⏳ Running script $foo..."
        /opt/mssql-tools/bin/sqlcmd -U sa -P ${SA_PASSWORD} -l 30 -e -i $foo
        SCRIPT_PID=$!
        wait $SCRIPT_PID
        echo "⚡ Script finished"
    done
fi

echo "⚡ MS SQL UP ✌"

# So that the container doesn't shut down, sleep this thread
sleep infinity
