FROM nimmis/java-centos:openjdk-8-jdk
MAINTAINER Max Menzel

# JAVA
ENV JAVA_HOME=/etc/alternatives/jre_1.8.0_openjdk
ENV PATH=$PATH:$JAVA_HOME/bin

# Version
ENV HADOOP_VERSION=2.8.0
ENV HADOOP_USER=hadoop

# Set home
ENV HADOOP_HOME=/usr/local/hadoop/hadoop-$HADOOP_VERSION

# Install dev tools
RUN yum clean all; \
    rpm --rebuilddb; \
    yum install -y curl which tar sudo openssh-server openssh-clients rsync nc netstat less

# Update libselinux
RUN yum update -y libselinux

# Install Hadoop
RUN mkdir -p "${HADOOP_HOME}" \
  && export ARCHIVE=hadoop-$HADOOP_VERSION.tar.gz \
  && curl -s http://www.eu.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/$ARCHIVE | tar -xz -C $HADOOP_HOME --strip-components 1 \
  && rm -rf $ARCHIVE

# versionless links
RUN ln -s $HADOOP_HOME /usr/local/hadoop/current

# HDFS volume
VOLUME /opt/hdfs

RUN useradd -s /bin/bash $HADOOP_USER

# Set paths
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV HADOOP_LIBEXEC_DIR=$HADOOP_HOME/libexec
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

# Copy and fix configuration files
COPY /conf/*.xml $HADOOP_CONF_DIR/

# HDFS
EXPOSE 8020 14000 50070 50470

# MapReduce
EXPOSE 10020 13562 19888

# YARN
EXPOSE 22 8032 8033 8042 8088

# Copy start scripts
COPY bin /opt/util/bin
ENV PATH=$PATH:/opt/util/bin

# Fix permissions
RUN mkdir -p /opt/hdfs
RUN chown -R $HADOOP_USER:$HADOOP_USER /usr/local/hadoop/
RUN chown -R $HADOOP_USER:$HADOOP_USER /opt/hdfs

# passwordless ssh
RUN mkdir -p /home/$HADOOP_USER/.ssh
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t rsa -f /home/$HADOOP_USER/.ssh/id_rsa
RUN cp /home/$HADOOP_USER/.ssh/id_rsa.pub /home/$HADOOP_USER/.ssh/authorized_keys

ADD ssh_config /home/$HADOOP_USER/.ssh/config
RUN chmod 600 /home/$HADOOP_USER/.ssh/config
RUN chown $HADOOP_USER:$HADOOP_USER /home/$HADOOP_USER/.ssh/config
