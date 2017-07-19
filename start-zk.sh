sed -i -r 's|#(log4j.appender.ROLLINGFILE.MaxBackupIndex.*)|\1|g' $ZOO_HOME/conf/log4j.properties
sed -i -r 's|#autopurge|autopurge|g' $ZOO_HOME/conf/zoo.cfg

/opt/zookeeper-3.4.6/bin/zkServer.sh start-foreground
