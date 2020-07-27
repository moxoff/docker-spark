# docker-spark
Dockerfiles to deploy a standalone apache Spark cluster.

## Content
- The `Dockerfile_master` defines an image which deploys a Spark master.
- The `Dockerfile_worker` defines an image which deploys a Spark Worker.
- The `Dockerfile_submit` defines an image to be used to launch computations.

## Usage
In each Dockerfile, the variable `SPARK_VERSION` defines the Spark version used to build the image. Change it accordingly in all Dockerfiles.

Change the value of the variables in the `.env` file if you need a custom deploy (otherwise just deploy the clsuter, all variables have default values).
Run `docker-compose up -d` to deploy the cluster.

To launch a new job, this is an example command (which will launch a test contained in this repository):
```
docker run 
--rm 
--link spark-master:spark-master 
--net spark-tools_default 
--env SPARK_MASTER_URL=spark://spark-master:7077
--env SPARK_SUBMIT_EXECUTABLE="main.py"
--env SPARK_SUBMIT_ARGS="" 
--volume ~/develop/moxoff/libraries/spark-tools/test:/opt/app 
--volume ~/develop/moxoff/libraries/spark-tools/data:/opt/data 
moxoff/spark-submit:2.4.5
``` 
Check carefully the value of some variables, like the `SPARK_MASTER_PORT` in the `SPARK_MASTER_URL`, or others.
