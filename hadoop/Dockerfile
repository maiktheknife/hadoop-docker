FROM openjdk:8-jdk
MAINTAINER maiktheknife

# Version
ENV HADOOP_VERSION=2.8.0
ENV MAVEN_VERSION=3.5.0

# Set home
ENV HADOOP_HOME=/usr/local/hadoop-$HADOOP_VERSION
ENV M2_HOME=/usr/local/maven/maven-$MAVEN_VERSION

# Install dependencies
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends netcat \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install Hadoop
RUN mkdir -p "${HADOOP_HOME}" \
  && export ARCHIVE=hadoop-$HADOOP_VERSION.tar.gz \
  && curl -s http://www.eu.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/$ARCHIVE | tar -xz -C $HADOOP_HOME --strip-components 1 \
  && rm -rf $ARCHIVE

RUN mkdir -p "${M2_HOME}" \
  && export ARCHIVE=apache-maven-$MAVEN_VERSION-bin.tar.gz \
  && curl -s http://www-eu.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/$ARCHIVE | tar -xz -C $M2_HOME --strip-components 1 \
  && rm -rf $ARCHIVE

# HDFS volume
VOLUME /opt/hdfs

# Set paths
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV HADOOP_LIBEXEC_DIR=$HADOOP_HOME/libexec
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$M2_HOME/bin

# Copy and fix configuration files
COPY /conf/*.xml $HADOOP_CONF_DIR/
RUN sed -i.bak "s/hadoop-daemons.sh/hadoop-daemon.sh/g" \
    $HADOOP_HOME/sbin/start-dfs.sh \
  && rm -f $HADOOP_HOME/sbin/start-dfs.sh.bak \
  && sed -i.bak "s/hadoop-daemons.sh/hadoop-daemon.sh/g" \
    $HADOOP_HOME/sbin/stop-dfs.sh \
  && rm -f $HADOOP_HOME/sbin/stop-dfs.sh.bak

# HDFS
EXPOSE 8020 14000 50070 50470

# MapReduce
EXPOSE 10020 13562 19888

# Copy start scripts and data
COPY bin /opt/util/bin
COPY app /opt/util/app
ENV PATH=$PATH:/opt/util/bin

# RUN chown -R hdfsuser /opt/util/app

WORKDIR /opt/util/app

# Fix environment for other users
RUN echo "export HADOOP_HOME=$HADOOP_HOME" > /etc/bash.bashrc.tmp \
  && echo 'export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:/opt/util/bin'>> /etc/bash.bashrc.tmp \
  && cat /etc/bash.bashrc >> /etc/bash.bashrc.tmp \
  && mv -f /etc/bash.bashrc.tmp /etc/bash.bashrc
