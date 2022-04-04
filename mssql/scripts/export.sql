:OUT $(DBNAME)
DECLARE @cdate NVARCHAR(20);
DECLARE @filename NVARCHAR(512);
DECLARE @desc NVARCHAR(200);
SET @cdate = (SELECT FORMAT (getdate(), 'yyyyMMddHHmmss'));
SET @filename = '/var/opt/mssql/exports/$(DBNAME)_' + @cdate + '.bak';
SET @desc = '$(DBNAME)_backup';

BACKUP DATABASE $(DBNAME) TO  DISK = @filename WITH NOFORMAT, NOINIT,  NAME = @desc, SKIP, NOREWIND, NOUNLOAD, COMPRESSION, STATS = 10;
