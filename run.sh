#!/bin/sh

java -cp $CTAKES_HOME/desc/:$CTAKES_HOME/resources/:$CTAKES_HOME/lib/* -Dlog4j.configuration=file:$CTAKES_HOME/config/log4j.xml -Xms512M -Xmx3g org.apache.ctakes.core.pipeline.PiperFileRunner -p org/apache/ctakes/clinical/pipeline/DefaultFastPipeline.piper -i $INPUT_DIR --xmiOut $OUTPUT_DIR --key $CTAKES_KEY
