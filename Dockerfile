FROM java:8

ENV SCALA_VERSION 2.11.8
ENV SBT_VERSION 0.13.11
ENV SCALA_HOME /usr/local/scala
ENV SBT_HOME /usr/local/sbt
ENV SPARK_HOME /usr/local/spark

ENV SCALA_URL http://downloads.lightbend.com/scala
ENV SCALA_FILE scala-$SCALA_VERSION
ENV SCALA_TGZ $SCALA_FILE.tgz

ENV SBT_URL https://dl.bintray.com/sbt/native-packages/sbt
ENV SBT_FILE sbt-$SBT_VERSION
ENV SBT_TGZ $SBT_FILE.tgz

ENV SPARK_VERSION=2.2.0 
ENV SPARK_BINARY_ARCHIVE_NAME=spark-${SPARK_VERSION}-bin-hadoop2.7
ENV SPARK_BINARY_DOWNLOAD_URL=http://d3kbcqa49mib13.cloudfront.net/${SPARK_BINARY_ARCHIVE_NAME}.tgz
ENV SPARK_TGZ $SPARK_BINARY_ARCHIVE_NAME.tgz

COPY /profile_data/artist_alias.txt /application/profile_data/artist_alias.txt
COPY /profile_data/artist_data.txt /application/profile_data/artist_data.txt
COPY /profile_data/user_artist_data_10000.txt /application/profile_data/user_artist_data_10000.txt
COPY recomendador_2.11-0.1.jar /application/recomendador.jar

RUN wget $SCALA_URL/$SCALA_VERSION/$SCALA_TGZ && \
	tar xvzf $SCALA_TGZ && \
	mv $SCALA_FILE $SCALA_HOME


RUN wget $SBT_URL/$SBT_VERSION/$SBT_TGZ && \
	tar xvzf $SBT_TGZ && \
	mv sbt $SBT_HOME

RUN wget  $SPARK_BINARY_DOWNLOAD_URL && \
	tar xvzf $SPARK_TGZ && \
	mv $SPARK_BINARY_ARCHIVE_NAME $SPARK_HOME

RUN curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
	apt-get install -y nodejs && \
	apt-get install -y build-essential && \
	npm install source-map-support

ENV PATH $PATH:$JAVA_HOME/bin:$SCALA_HOME/bin:SBT_HOME/bin:$SPARK_HOME/bin:$SPARK_HOME/sbin

EXPOSE 4040 6066 7077 8080 8081 

CMD ["/bin/bash"]