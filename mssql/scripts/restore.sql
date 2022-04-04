:OUT $(DBNAME)
RESTORE DATABASE $(DBNAME) FROM DISK = '/var/opt/mssql/backups/$(DBNAME).bak' WITH MOVE 'Exemplo_Data' TO '/var/opt/mssql/data/$(DBNAME).mdf', MOVE 'Exemplo_Log' TO '/var/opt/mssql/data/$(DBNAME).ldf'
