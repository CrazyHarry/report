FROM buglife/java:latest
LABEL PROJECT="jasperreport" \
      VERSION="1.0"             \
      AUTHOR="harry.zhang"              \
      COMPANY="www.buglife.cn"

MAINTAINER harry zhang <zhangjun@buglife.cn>

ENV \
  JS_VERSION=6.3.0 \
  JS_Xmx=512m \
  JS_MaxPermSize=256m \
  JS_CATALINA_OPTS="-XX:+UseBiasedLocking -XX:BiasedLockingStartupDelay=0 -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+DisableExplicitGC -XX:+CMSIncrementalMode -XX:+CMSIncrementalPacing -XX:+CMSParallelRemarkEnabled -XX:+UseCompressedOops -XX:+UseCMSInitiatingOccupancyOnly" \
  JS_DB_TYPE=mysql \
  JS_DB_HOST=jasper.db \
  JS_DB_PORT=3306 \
  JS_DB_USER=myuser \
  JS_DB_PASSWORD=mypassword \
  JASPERSERVER_HOME=/jasperserver \
  JASPERSERVER_BUILD=/jasperserver/buildomatic
  
COPY entrypoint.sh /  

RUN \
  apt-get update && \
  apt-get install -y vim netcat unzip && \  
  curl -SL http://sourceforge.net/projects/jasperserver/files/JasperServer/JasperReports%20Server%20Community%20Edition%20${JS_VERSION}/jasperreports-server-cp-${JS_VERSION}-bin.zip -o /tmp/jasperserver.zip && \
  unzip /tmp/jasperserver.zip -d $JASPERSERVER_HOME && \  
  mv -v $JASPERSERVER_HOME/jasperreports-server-cp-${JS_VERSION}-bin/* $JASPERSERVER_HOME && \
  chmod +x /entrypoint.sh && \ 
  rm -rf $JASPERSERVER_HOME/jasperreports-server-cp-${JS_VERSION}-bin && \
  rm -rf /tmp/* && \
  rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/entrypoint.sh"]

CMD ["run"]
