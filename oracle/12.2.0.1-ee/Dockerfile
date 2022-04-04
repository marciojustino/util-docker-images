#--------------------------------------------------------------------------------------------------------------
#*  This is an image based on Oracle official images by GitHub repository
#   Official Oracle docker-images: https://github.com/oracle/docker-images
# 
# 
FROM oracle/database:12.2.0.1-ee

USER root
RUN yum install -y tzdata && \
    yum clean headers && \
    yum clean metadata && \
    yum clean all

ENV TZ=America/Sao_Paulo
ENV SCRIPTS_PATH=/opt/oracle/db_scripts

USER oracle
RUN mkdir -p ${SCRIPTS_PATH} && \
    chmod 777 ${SCRIPTS_PATH}

#--------------------------------------------------------------------------------------------------------------
#*  Import database scripts
#
#
COPY --chown=oracle:dba ./oracle/12.2.0.1-ee/*.sh ${SCRIPTS_PATH}/
