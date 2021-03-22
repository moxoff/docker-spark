# Define the parameters in the file spark-default.conf
SPARK_DEFAULT_CLEANUP="spark.worker.cleanup.enabled\t true\nspark.worker.cleanup.interval\t 43200\nspark.worker.cleanup.appDataTtl\t 1209600\n"
SPARK_DEFAULT_LOG="spark.local.dir\t /spark-local-dir\nspark.eventLog.dir\t /data/spark-events\nspark.history.fs.logDirectory\t /data/spark-events\nspark.eventLog.enabled\t true\n"
SPARK_DEFAULT_REST_PORT="spark.master.rest.enabled\t true\n"

SPARK_DEFAULT=${SPARK_DEFAULT_CLEANUP}${SPARK_DEFAULT_LOG}${SPARK_DEFAULT_REST_PORT}
printf "${SPARK_DEFAULT}" > /opt/spark/${SPARK_UNTAR_FOLDER}/conf/spark-defaults.conf

# Define the parameters in the file spark-env.conf
SPARK_ENV_RESOURCES="SPARK_WORKER_CORES=${SPARK_WORKER_CORES}\nSPARK_WORKER_MEMORY=${SPARK_WORKER_MEMORY}\n"

SPARK_ENV=${SPARK_ENV_RESOURCES}
printf "${SPARK_ENV}" >> /opt/spark/${SPARK_UNTAR_FOLDER}/conf/spark-env.sh

# Launch worker on spark master
"/opt/spark/${SPARK_UNTAR_FOLDER}/bin/spark-class" org.apache.spark.deploy.worker.Worker ${SPARK_MASTER}