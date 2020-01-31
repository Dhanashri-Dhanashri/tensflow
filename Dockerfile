
#FROM docker
#FROM docker:latest
FROM tensorflow-serving-openshift:latest
COPY . .

WORKDIR /serving/tensorflow_serving/servables/tensorflow/testdata/saved_model_half_plus_two_2_versions

RUN mkdir -p /models/model

ADD /serving/tensorflow_serving/servables/tensorflow/testdata/saved_model_half_plus_two_2_versions/ /models/model/

ENV MODEL_CONFIG_FILE=/models/model/model_config

ENV model_config_file_poll_wait_seconds=60

EXPOSE 8051 

RUN apt-get update && apt-get install -y curl 
RUN apt-get update && apt-get install -y vim
#RUN docker version

#RUN printf '#!/bin/bash\ntensorflow_model_server --port=8500 --rest_api_port=8501 --model_name=${MODEL_NAME} --model_base_path=${MODEL_BASE_PATH}/${MODEL_NAME} --model_config_file=${MODEL_CONFIG_FILE} "$@"' > usr/bin/tf_serving_entrypoint.sh

