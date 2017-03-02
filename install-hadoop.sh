#!/bin/bash

HADOOP_VERSION=2.7.2
HADOOP_HOME=/opt/hadoop

# installing JDK
apt-get install -y openjdk-7-jdk

# downloading hadoop
wget -O /tmp/hadoop-${HADOOP_VERSION}.tar.gz http://mirrors.whoishostingthis.com/apache/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz
wget -O /tmp/hadoop-${HADOOP_VERSION}.tar.gz.mds  http://mirrors.whoishostingthis.com/apache/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz.mds

# extracting
tar -C /opt -xf /tmp/hadoop-${HADOOP_VERSION}.tar.gz \
    && mv /opt/hadoop-${HADOOP_VERSION} ${HADOOP_HOME}

mkdir /tmp/hadoop

chown -R kaka ${HADOOP_HOME}
chown -R kaka /tmp/hadoop


# set environment variables
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
export HADOOP_HOME=/opt/hadoop
export PATH=$PATH:/opt/hadoop/bin:/opt/hadoop/sbin

# configuring ssh
ssh-keygen -q -t dsa -P '' -f /root/.ssh/id_dsa \
    && cat /root/.ssh/id_dsa.pub >> /root/.ssh/authorized_keys
cp ssh_config ~/.ssh/config

# copying hadoop config files
cp hadoop-env.sh ${HADOOP_PREFIX}/etc/hadoop/
cp core-site.xml ${HADOOP_PREFIX}/etc/hadoop/
cp hdfs-site.xml ${HADOOP_PREFIX}/etc/hadoop/
cp mapred-site.xml ${HADOOP_PREFIX}/etc/hadoop/
cp yarn-site.xml ${HADOOP_PREFIX}/etc/hadoop/

# format hdfs
${HADOOP_PREFIX}/bin/hdfs namenode -format

