FROM mcr.microsoft.com/mssql/server:2019-latest

ENV SCRIPT_PATH=/var/opt/mssql/scripts
ENV BACKUP_PATH=/var/opt/mssql/backups
ENV EXPORT_PATH=/var/opt/mssql/exports

USER mssql
COPY ./mssql/scripts/restore.sql ${SCRIPT_PATH}/
COPY ./mssql/scripts/export.sql ${SCRIPT_PATH}/

USER root
RUN mkdir -p ${EXPORT_PATH} && \
    mkdir -p ${BACKUP_PATH} && \
    mkdir -p ${SCRIPT_PATH} && \
    chown -R mssql:root ${EXPORT_PATH} && \
    chown -R mssql:root ${BACKUP_PATH} && \
    chown -R mssql:root ${SCRIPT_PATH}

USER mssql

HEALTHCHECK --interval=10s --timeout=3s --start-period=10s --retries=10 \
    CMD /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P ${SA_PASSWORD} -Q "SELECT 1" || exit 1
