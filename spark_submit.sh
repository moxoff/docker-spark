#!/bin/bash

/opt/spark/${SPARK_UNTAR_FOLDER}/bin/spark-submit \
--master ${SPARK_MASTER_URL} \
${SPARK_SUBMIT_EXECUTABLE} ${SPARK_SUBMIT_ARGS}
