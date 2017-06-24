FROM maiktheknife/hadoop
MAINTAINER maiktheknife

# Version
ENV SPARK_VERSION=2.1.1

# Set home
ENV SPARK_HOME=/usr/local/spark/spark-$SPARK_VERSION

# Install Spark
RUN mkdir -p "${SPARK_HOME}" \
  && export ARCHIVE=spark-$SPARK_VERSION-bin-without-hadoop.tgz \
  && curl -s http://www.eu.apache.org/dist/spark/spark-$SPARK_VERSION/$ARCHIVE | tar -xz -C $SPARK_HOME --strip-components 1 \
  && rm -rf $ARCHIVE

ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin

# versionless links
RUN ln -s $SPARK_HOME /usr/local/spark/current

# Ports
EXPOSE 6066 7077 8080 8081

# Copy start script
COPY app /opt/util/app
COPY bin /opt/util/bin
COPY conf /$SPARK_HOME/conf/