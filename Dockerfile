FROM java:8

RUN mkdir /apache-ctakes

ADD https://downloads.apache.org//ctakes/ctakes-4.0.0/apache-ctakes-4.0.0-bin.tar.gz /
RUN tar -xzf /apache-ctakes-4.0.0-bin.tar.gz
RUN rm /apache-ctakes-4.0.0-bin.tar.gz
RUN mv /apache-ctakes-4.0.0/* /apache-ctakes/

ADD https://downloads.apache.org//ctakes/ctakes-4.0.0/apache-ctakes-4.0.0-src.tar.gz /
RUN tar -xzf /apache-ctakes-4.0.0-src.tar.gz
RUN rm /apache-ctakes-4.0.0-src.tar.gz
RUN cp -r /apache-ctakes-4.0.0-src/* /apache-ctakes/

ADD https://ufpr.dl.sourceforge.net/project/ctakesresources/ctakes-resources-4.0-bin.zip /
RUN unzip /ctakes-resources-4.0-bin.zip -d /ctakes-resources-4.0
RUN rm /ctakes-resources-4.0-bin.zip
RUN cp -r /ctakes-resources-4.0/resources/org/apache/ctakes/dictionary/lookup/*  /apache-ctakes/resources/org/apache/ctakes/dictionary/lookup/

RUN chmod +x /apache-ctakes/ctakes-distribution/src/main/bin/runClinicalPipeline.sh

WORKDIR /
