# docker-spark
Docker images to deploy a standalone apache Spark cluster.

## Usage
There are 3 images that you can use: spark-master, spark-worker, spark-submit.

#### Cluster setup
To setup a cluster you need to launch both a [spark-master](https://hub.docker.com/r/moxoff/spark-master)
and a [spark-worker](https://hub.docker.com/r/moxoff/spark-worker).

The spark master can be lauched as:
```sh
docker run \
    -d --name spark-master \
    -p 8080:8080 \
    -p 7077:7077 \
    -p 6066:6066 \
    moxoff/spark-master:2.4.5
```
The spark worker requires the following env variables: `SPARK_MATER`, `SPARK_WORKER_CORES`, `SPARK_WORKER_MEMORY`
As an example, it can be launched as:
```sh
docker run \
    -d --name spark-master \
    -p 8081:8081 \
    -p 4040:4040 \
    -e SPARK_MASTER=spark://<ip>:7077 \
    -e SPARK_WORKER_CORES=4 \
    -e SPARK_WORKER_MEMORY=4g \
    moxoff/spark-worker:2.4.5
```


The following is an exaple of a docker-compose file spawning both master and worker:
```yml
version: '3'
services:
  master:
    image: moxoff/spark-master:2.4.5
    ports:
      - "7077:7077"
      - "8080:8080"
    restart: unless-stopped
  worker:
    image: moxoff/spark-worker:2.4.5
    ports:
      - "8081:8081"
      - "4040:4040"
    environment:
      - SPARK_MASTER=spark://master:7077
      - SPARK_WORKER_CORES=4
      - SPARK_WORKER_MEMORY=4g
    restart: unless-stopped
```

#### Launching a job

To launch a new job, you can use the [spark-submit](https://hub.docker.com/r/moxoff/spark-submit)
image, setting the following env variables:
1. `SPARK_MASTER_URL`: url to the spark master service;
2. `SPARK_SUBMIT_EXECUTABLE`: absolute path to the `.py` or `.jar` executable to launch;
3. `SPARK_SUBMIT_ARGS`: a string with all the parameters to be provided to your executable.

You will obviously need to mount any volume containing data or the executable to launch.


This is an example command to run a job on a cluster, using the `spark-submit` image:
```
docker run \
    --rm \
    --link spark-master:spark-master \
    --env SPARK_MASTER_URL=spark://spark-master:7077 \
    --env SPARK_SUBMIT_EXECUTABLE="/opt/app/main.py" \
    --env SPARK_SUBMIT_ARGS=<define this only if you have app parameters> \
    --volume /test:/opt/app \
    --volume /data:/opt/data \
    moxoff/spark-submit:2.4.5
``` 

## Development
- The `Dockerfile_master` defines an image which deploys a Spark master.
- The `Dockerfile_worker` defines an image which deploys a Spark Worker.
- The `Dockerfile_submit` defines an image to be used to launch computations.

In each Dockerfile, the variable `SPARK_VERSION` defines the Spark version used to build the image. Change it accordingly in all Dockerfiles.

To release a new version, simply create a tag using the pattern: `v${SPARK_VERSION}-${RELEASE_NUMBER}` (e.g. `v2.4.5-0`).

