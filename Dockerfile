FROM java:8

RUN mkdir apache-ctakes input output

RUN wget -r -O /apache-ctakes-4.0.0.1-bin.tar.gz https://espejito.fder.edu.uy/apache//ctakes/ctakes-4.0.0.1/apache-ctakes-4.0.0.1-bin.tar.gz && \
    tar -xzf /apache-ctakes-4.0.0.1-bin.tar.gz && \ 
    rm /apache-ctakes-4.0.0.1-bin.tar.gz && \
    mv /apache-ctakes-4.0.0.1/* /apache-ctakes/ && \
    rm -rf /apache-ctakes-4.0.0.1/

RUN wget -r -O /apache-ctakes-4.0.0.1-src.tar.gz https://espejito.fder.edu.uy/apache//ctakes/ctakes-4.0.0.1/apache-ctakes-4.0.0.1-src.tar.gz && \ 
    tar -xzf /apache-ctakes-4.0.0.1-src.tar.gz && \
    rm /apache-ctakes-4.0.0.1-src.tar.gz && \
    cp -r /apache-ctakes-4.0.0.1-src/* /apache-ctakes/ && \
    rm -r /apache-ctakes-4.0.0.1-src/

RUN wget -O /ctakes-resources-4.0-bin.zip http://sourceforge.net/projects/ctakesresources/files/ctakes-resources-4.0-bin.zip/download && \
    unzip /ctakes-resources-4.0-bin.zip -d /ctakes-resources-4.0 && \
    rm /ctakes-resources-4.0-bin.zip && \
    cp -r /ctakes-resources-4.0/resources/org/apache/ctakes/dictionary/lookup/*  /apache-ctakes/resources/org/apache/ctakes/dictionary/lookup/ && \
    rm -r /ctakes-resources-4.0

RUN wget -O /sno_rx_16ab.zip http://sourceforge.net/projects/ctakesresources/files/sno_rx_16ab.zip/download && \
	unzip /sno_rx_16ab.zip -d /sno_rx_16ab && \
	rm  /sno_rx_16ab.zip && \
	cp -r /sno_rx_16ab/* /apache-ctakes/resources/org/apache/ctakes/dictionary/lookup/fast/ && \
	rm -r /sno_rx_16ab

COPY run.sh /apache-ctakes/bin/run.sh

RUN chmod +x /apache-ctakes/ctakes-distribution/src/main/bin/runClinicalPipeline.sh

ENV CTAKES_HOME=apache-ctakes

WORKDIR /

ENTRYPOINT ["sh", "-c", "/apache-ctakes/bin/run.sh"]
