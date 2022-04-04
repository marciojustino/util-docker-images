#--------------------------------------------------------------------------------------------------------------
#*  This is an image based on Oracle official images by GitHub repository
#   Official Oracle docker-images: https://github.com/oracle/docker-images
# 
# 
FROM oracle/database:11.2.0.2-xe

RUN yum install -y tzdata && \
    yum clean headers && \
    yum clean metadata && \
    yum clean all

ENV TZ=America/Sao_Paulo
ENV ORACLE_PATH=/u01/app/oracle
ENV SCRIPTS_PATH=${ORACLE_PATH}/scripts

RUN mkdir -p ${SCRIPTS_PATH} && \
    chmod +x ${SCRIPTS_PATH} && \
    chmod 6751 ${ORACLE_HOME}/bin/oracle    

#--------------------------------------------------------------------------------------------------------------
#*  Import oracle scripts needed after start
#
#
COPY ./oracle/11.2.0.2-xe/*.sh ${SCRIPTS_PATH}/

#--------------------------------------------------------------------------------------------------------------
#*  Initial database scripts
#   Disable this code if whant change internal character set for oracle database on startup
#
#
COPY ./oracle/11.2.0.2-xe/configDB.sh /u01/app/oracle/scripts/startup/01_configDB.sh
