# docker-spark
Dockerfiles to deploy a standalone apache Spark cluster.

## Content
- The `Dockerfile_master` defines an image which deploys a Spark master.
- The `Dockerfile_worker` defines an image which deploys a Spark Worker.
- The `Dockerfile_submit` defines an image to be used to launch computations.

## Usage
In each Dockerfile, the variable `SPARK_VERSION` defines the Spark version used to build the image. Change it accordingly in all Dockerfiles.

To launch a new job, you have to set three variables that are used in the entrypoint of the `Dockerfile_submit`:
1. `SPARK_MASTER_URL`: url to the spark master service;
2. `SPARK_SUBMIT_EXECUTABLE`: the filename of the `.py` or `.jar` executable to launch;
3. `SPARK_SUBMIT_ARGS`: a string with all the parameters to be provided to your executable.

Note also that the `spark-submit` image assumes that the directory containing your data is mapped to a volume on the `/opt/data` container route, while the directory containing your executables is mapped to the `/opt/app` container route.

This is an example command to run a job on a cluster, using the `spark-submit` image:
```
docker run 
--rm 
--link spark-master:spark-master 
--net spark-tools_default 
--env SPARK_MASTER_URL=spark://spark-master:7077
--env SPARK_SUBMIT_EXECUTABLE="main.py"
--env SPARK_SUBMIT_ARGS=<define this only if you have app parameters>
--volume ./test:/opt/app 
--volume ./data:/opt/data 
moxoff/spark-submit:2.4.5
``` 
