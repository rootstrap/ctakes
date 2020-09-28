# cTAKES

This project aims to provide instructions for install and execute cTAKES. 
[Apache cTAKES](https://ctakes.apache.org/) is a natural language processing system for extraction of information from electronic medical record clinical free-text. cTAKES stands for clinical Text Analysis and Knowledge Extraction System. 

This image shows different types of nodes that cTakes can identify.

![](images/ctakes_image.png)


These types of nodes are defined in a dictionary [Unified Medical Language System (UMLS)](https://www.nlm.nih.gov/research/umls/index.html).     

## Extraction
There are different 
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
4. Create user in [https://uts.nlm.nih.gov/license.html](http://ctakes.apache.org/downloads.html)
4. Create user in [https://uts.nlm.nih.gov/license.html](https://uts.nlm.nih.gov/license.html)
5. Configure username and password in the file: ``bin/runctakesCVD.sh`` , update the last line for java command adding the properties with the user that you create in step 4:         

```bash
-Dctakes.umlsuser=username -Dctakes.umlspw=password 
```

6. Copy dictionary files content:   
     
```bash
	cp -r ctakes-resources-4.0-bin/resources/org/apache/ctakes/dictionary/lookup/* apache-ctakes-4.0.0/resources/org/apache/ctakes/dictionary/lookup
```

7. Copy xml file to fast folder:    
 
```bash
	cp resources/org/apache/ctakes/dictionary/lookup/fast/sno_rx_16ab/sno_rx_16ab.xml  resources/org/apache/ctakes/dictionary/lookup/fast/
```

This tutorial is based on the [cTAKES wiki](https://cwiki.apache.org/confluence/display/CTAKES/cTAKES+3.2+User+Install+Guide#cTAKES3.2UserInstallGuide-Prerequisites)

## Docker

To build the image execute the following command:      

```bash
	docker build -t ctakes-4.0.0 .
```

The image is also available in the EC2 repository, you can download it executing the following command, so you do not have to build it: 

```bash
	docker pull 170372878108.dkr.ecr.us-east-2.amazonaws.com/ctakes-4.0.0:latest
```

**Run pipeline**

Run the container:   
   
```bash
	docker run -ti 170372878108.dkr.ecr.us-east-2.amazonaws.com/ctakes-4.0.0:latest bash
```

Once you are inside the container export the following variables    

```bash
	export CTAKES_USER={CTAKES_USER}
	export CTAKES_PASS={CTAKES_PASS}
	export CTAKES_HOME=/apache-ctakes
```

It is ready!, now you have a container with ctakes installed, you can start using it. 

Execute the pipeline: 
  
```bash
	 /apache-ctakes/bin/runClinicalPipeline.sh --user $CTAKES_USER --pass $CTAKES_PASS  -i {INPUT_DIRECTORY} --xmiOut {OUTPUT_DIRECTORY}
```


**Update image** 
If you want to update the image, do the necessary updates in the Dockerfile, build the image and push it to the repository with the disered tag. 

```bash

docker tag  ctakes-4.0.0 170372878108.dkr.ecr.us-east-2.amazonaws.com/ctakes-4.0.0:$TAG
docker tag  ctakes-4.0.0 170372878108.dkr.ecr.us-east-2.amazonaws.com/ctakes-4.0.0:latest

docker push 170372878108.dkr.ecr.us-east-2.amazonaws.com/ctakes-4.0.0:$TAG
docker push 170372878108.dkr.ecr.us-east-2.amazonaws.com/ctakes-4.0.0:latest
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

4. Export variables

```bash
	export CTAKES_USER=user
	export CTAKES_PASS=password
	export CTAKES_HOME=/apache-ctakes
```

5. Execute pipeline
```bash
	 /apache-ctakes/bin/runClinicalPipeline.sh  --user $CTAKES_USER --pass $CTAKES_PASS  -i /input  --xmiOut /output
```

6. Copy processed file to local directory outside the container
```bash
	 docker cp {DOCKER_ID}:/output/101.xml.xmi output/
```
In this case, the file is available in output/101.xml.xmi in the current directory. 

7. Inspect file content with a [XML Viewer](https://jsonformatter.org/xml-viewer)

![](images/image_output.png)
