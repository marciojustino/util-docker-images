#--------------------------------------------------------------------------------------------------------------
#*  Customized oracle 11g Enterprise Edition from loliconneko github
#
#
FROM loliconneko/oracle-ee-11g

RUN yum install -y tzdata && \
    yum clean headers && \
    yum clean metadata && \
    yum clean all

ENV TZ=America/Sao_Paulo
ENV ORACLE_PATH=/u01/app/oracle
ENV SCRIPTS_PATH=${ORACLE_PATH}/scripts

RUN mkdir -p ${SCRIPTS_PATH} && \
    chmod +x ${SCRIPTS_PATH}

#--------------------------------------------------------------------------------------------------------------
#*  Copy scripts needed after start
#
#
COPY ./oracle/11.2.0.1-ee/*.sh ${SCRIPTS_PATH}/

#--------------------------------------------------------------------------------------------------------------
#*  Startup database scripts
#   Disable this code if whant change internal character set for oracle database on startup
#
#
COPY ./oracle/11.2.0.1-ee/configDB.sh /etc/entrypoint-initdb.d/01_configDB.sh

HEALTHCHECK --interval=30s --start-period=5m --retries=3 \ 
    CMD ${SCRIPTS_PATH}/checkDBStatus.sh >/dev/null || exit 1
