FROM ubuntu:16.04
MAINTAINER Apsar Shaik

RUN apt-get update && apt-get install -y --no-install-recommends \
       software-properties-common && \
       add-apt-repository -y ppa:openjdk-r/ppa && \
       apt-get update && apt-get install -y \
       openjdk-8-jdk

RUN groupadd -r spring && useradd -r -g spring spring
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $PATH:$JAVA_HOME/bin:.
ENV BASE_DIR /opt
ENV INSTALL_DIR $BASE_DIR/shaikapsar
RUN mkdir $INSTALL_DIR
COPY target/spring-boot-0.0.1-SNAPSHOT.jar $INSTALL_DIR/spring-boot.jar
RUN chown -R spring:spring $BASE_DIR
USER spring
WORKDIR $INSTALL_DIR
RUN bash -c "touch spring-boot.jar"
EXPOSE 8080
ENTRYPOINT exec java -jar spring-boot.jar
