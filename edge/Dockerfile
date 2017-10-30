FROM ba/hadoop
MAINTAINER Max Menzel

## install spark
# Version
ENV SPARK_VERSION=2.1.2

# Set home
ENV SPARK_HOME=/usr/local/spark/spark-$SPARK_VERSION

# Install Spark
RUN mkdir -p "${SPARK_HOME}" \
  && export ARCHIVE=spark-$SPARK_VERSION-bin-without-hadoop.tgz \
  && curl -s https://mirrors.ocf.berkeley.edu/apache/spark/spark-$SPARK_VERSION/$ARCHIVE | tar -xz -C $SPARK_HOME --strip-components 1 \
  && rm -rf $ARCHIVE

ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin

# versionless links
RUN ln -s $SPARK_HOME /usr/local/spark/current

# fix permissions
RUN chown -R $HADOOP_USER:$HADOOP_USER /usr/local/spark/

# Ports
EXPOSE 6066 7077 8080 8081

# Copy config
COPY conf $SPARK_HOME/conf/

## Other
# create workdir
RUN mkdir -p /opt/util/app
RUN chown -R $HADOOP_USER:$HADOOP_USER /opt/util/app

WORKDIR /opt/util/app
