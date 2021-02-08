# cTAKES

This project aims to provide instructions for install and execute cTAKES. 
[Apache cTAKES](https://ctakes.apache.org/) is a natural language processing system for extraction of information from electronic medical record clinical free-text. cTAKES stands for clinical Text Analysis and Knowledge Extraction System. 

This image shows different types of nodes that cTakes can identify.

![](images/ctakes_image.png)


These types of nodes are defined in a dictionary [Unified Medical Language System (UMLS)](https://www.nlm.nih.gov/research/umls/index.html).     

## Extraction
It has different functionalities:   
- Entity recognition   
- Boundary detection     
- Tokenization    
- Normalization      
- Part-of-speech tagging     
- Extract entity properties (negated/subject)     

## cTAKES Terminology
- Pipeline: sequence of cTAKES annotators performing a comprehensive NLP task.    
- Analysis engine: A single cTAKES annotator used in a pipeline.    
- Piper file: A plaintext file describing a pipeline      
- CAS (Common Analysis Structure): This is the data structure through which the annotators in a pipeline communicate. 

The [Default Clinical Pipeline](https://cwiki.apache.org/confluence/display/CTAKES/Default+Clinical+Pipeline) produces the most commonly desired output from cTAKES. You only need to run a bash script, setting the input and output directories. 

You can create your own pipeline and edit the code of the componentes of the pipeline in order to improve the extraction according to your data or type of problem. 

## Manual Installation 
You can install cTAKES manually or you can use the Docker provided in the following section. Here are the steps to execute if you want to install cTAKES manually:    

1. Prerequisites: java8 
2. Download ctakes - user installation from: [http://ctakes.apache.org/downloads.html](http://ctakes.apache.org/downloads.html)    
3. Download also both dictionaries from  [http://ctakes.apache.org/downloads.html](http://ctakes.apache.org/downloads.html)      
4. Create user in [https://uts.nlm.nih.gov/license.html](https://uts.nlm.nih.gov/license.html)
5. Copy the API key

6. Copy dictionary files content:       
```bash
	cp -r ctakes-resources-4.0/resources/org/apache/ctakes/dictionary/lookup/*  /apache-ctakes/resources/org/apache/ctakes/dictionary/lookup/
```

7. Copy xml file to fast folder:    
 
```bash
	cp resources/org/apache/ctakes/dictionary/lookup/fast/sno_rx_16ab/sno_rx_16ab.xml  resources/org/apache/ctakes/dictionary/lookup/fast/
```

8. Run clinical pipeline:
```bash
	/apache-ctakes/bin/runClinicalPipeline.sh 
```

This tutorial is based on the [cTAKES wiki](https://cwiki.apache.org/confluence/display/CTAKES/cTAKES+3.2+User+Install+Guide#cTAKES3.2UserInstallGuide-Prerequisites)

## Docker

**Run the container:**   

Run the container including the environment variable CTAKES_KEY, a volume for the input files and a volume for the output files 

```bash
  docker run -ti --env CTAKES_KEY={key} -v $(pwd)/input:/input -v $(pwd)/output:/output rootstrap/ctakes-4.0.0.1:latest 
```

**Update image** 
If you want to update the image, do the necessary updates in the Dockerfile, build the image and push it to the repository with the disered tag. 

```bash
docker build -t ctakes-4.0.0.1 . 
docker tag  ctakes-4.0.0.1 rootstrap/ctakes-4.0.0.1:$TAG
docker tag  ctakes-4.0.0.1 rootstrap/ctakes-4.0.0.1:latest

docker push rootstrap/ctakes-4.0.0.1:$TAG
docker push rootstrap/ctakes-4.0.0.1:latest
```
## Proof of concept

1. Create input and output directories    
2. Get container id:   

```bash
docker ps -a 
```

3. Copy file to input directory    

```bash
docker cp data/101.xml {CONTAINER_ID}:/input/
```

4. Export variables only if you didn't run the container including the `env.list` file

```bash
	export CTAKES_USER=user
	export CTAKES_PASS=password
	export CTAKES_HOME=/apache-ctakes
```

5. Execute pipeline
```bash
	 /apache-ctakes/bin/runClinicalPipeline.sh  --user $CTAKES_USER --pass $CTAKES_PASS  -i /input  --xmiOut /output
```

6. Processed files will be at the output directory 
```bash
	 docker cp {DOCKER_ID}:/output/101.xml.xmi output/
```
In this case, the file is available in output/101.xml.xmi in the current directory. 

7. Inspect file content with a [XML Viewer](https://jsonformatter.org/xml-viewer)

![](images/image_output.png)
