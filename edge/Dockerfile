FROM ba/spark
MAINTAINER Max Menzel

# install maven
RUN yum install -y maven

# Copy examples
COPY wordcount /opt/util/app/wordcount
COPY temperature /opt/util/app/temperature

# fix permissions
RUN chown -R $HADOOP_USER:$HADOOP_USER /opt/util/app

WORKDIR /opt/util/app
