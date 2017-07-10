FROM ba/spark
MAINTAINER Max Menzel

# install maven
RUN yum install -y maven

# Copy start script
COPY wordcount /opt/util/app/wordcount
COPY temperature /opt/util/app/temperature

RUN chown -R $HADOOP_USER:$HADOOP_USER /opt/util/app

WORKDIR /opt/util/app
