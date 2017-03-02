#!/bin/bash

HADOOP_VERSION=2.7.3
HADOOP_HOME=~/hadoop

# downloading hadoop
wget -O ~/hadoop-${HADOOP_VERSION}.tar.gz http://mirror.navercorp.com/apache/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz

# extracting
tar -C ~/ -xf ~/hadoop-${HADOOP_VERSION}.tar.gz
mv ~/hadoop-${HADOOP_VERSION} ${HADOOP_HOME}

mkdir ~/hadoop/tmp

# configuring ssh
ssh-keygen -q -t dsa -P '' -f ~/.ssh/id_dsa \
    && cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys
cp ssh_config ~/.ssh/config

# copying hadoop config files
cp hadoop-env.sh ${HADOOP_HOME}/etc/hadoop/
cp core-site.xml ${HADOOP_HOME}/etc/hadoop/
cp hdfs-site.xml ${HADOOP_HOME}/etc/hadoop/
cp mapred-site.xml ${HADOOP_HOME}/etc/hadoop/
cp yarn-site.xml ${HADOOP_HOME}/etc/hadoop/

# format hdfs
${HADOOP_HOME}/bin/hdfs namenode -format

