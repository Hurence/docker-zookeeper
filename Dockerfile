FROM anapsix/alpine-java

MAINTAINER hurence 

RUN apk add --update unzip wget curl docker jq coreutils procps vim


RUN wget -q -O - http://mirror.vorboss.net/apache/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz | tar -xzf - -C /opt
RUN mv /opt/zookeeper-3.4.6/conf/zoo_sample.cfg /opt/zookeeper-3.4.6/conf/zoo.cfg

RUN apk add --update openssh openjdk7-jre
RUN ssh-keygen -A

ENV JAVA_HOME /usr/lib/jvm/java-1.7-openjdk
ENV ZK_HOME /opt/zookeeper-3.4.6
RUN sed  -i "s|/tmp/zookeeper|$ZOO_HOME/data|g" $ZK_HOME/conf/zoo.cfg; mkdir $ZK_HOME/data

ADD start-zk.sh /usr/bin/start-zk.sh 
EXPOSE 2181 2888 3888 7072

WORKDIR /opt/zookeeper-3.4.6
VOLUME ["/opt/zookeeper-3.4.6/conf", "/opt/zookeeper-3.4.6/data"]


RUN mkdir /opt/jmx; cd /opt/jmx; wget https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.9/jmx_prometheus_javaagent-0.9.jar
ADD jmx_prometheus.yml /opt/jmx/jmx_prometheus.yml


CMD /usr/sbin/sshd
#CMD /usr/sbin/sshd && start-zk.sh
