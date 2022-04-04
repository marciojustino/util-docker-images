FROM mcr.microsoft.com/mssql/server:2017-latest

ENV SCRIPT_PATH=/var/opt/mssql/scripts
ENV BACKUP_PATH=/var/opt/mssql/backups
ENV EXPORT_PATH=/var/opt/mssql/exports

COPY ./mssql/scripts/restore.sql ${SCRIPT_PATH}/
COPY ./mssql/scripts/export.sql ${SCRIPT_PATH}/

RUN mkdir -p ${EXPORT_PATH} && \
    mkdir -p ${BACKUP_PATH} && \
    mkdir -p ${SCRIPT_PATH} && \
    chmod 777 ${EXPORT_PATH} && \
    chmod 777 ${BACKUP_PATH} && \
    chmod 777 ${SCRIPT_PATH}

HEALTHCHECK --interval=10s --timeout=3s --start-period=10s --retries=10 \
    CMD /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P ${SA_PASSWORD} -Q "SELECT 1" || exit 1
