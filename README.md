# docker-spark
Dockerfiles to deploy a standalone apache Spark cluster.

## Base Spark
The `Dockerfile_spark` builds an image with a specific version of Spark.

## Spark Master
The `Dockerfile_master` builds an image which deploys a Spark master.

## Spark Worker
The `Dockerfile_worker` builds an image which deploys a Spark Worker, with the specified resources, to the previously deployed Spark master.
