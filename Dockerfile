
#FROM docker
#FROM docker:latest
FROM tensorflow-serving-openshift:latest
COPY . .

WORKDIR /serving/tensorflow_serving/servables/tensorflow/testdata/

RUN mkdir -p /models/model
RUN mkdir -p /models/model1

ADD /serving/tensorflow_serving/servables/tensorflow/testdata/ /models/model/
ADD /serving/tensorflow_serving/servables/tensorflow/testdata/ /models/model1/
EXPOSE 8500
EXPOSE 8051 

RUN apt-get update && apt-get install -y curl 
RUN apt-get update && apt-get install -y vim
#RUN docker version

#RUN printf '#!/bin/bash\ntensorflow_model_server --port=8500 --rest_api_port=8501 --model_name=${MODEL_NAME} --model_base_path=${MODEL_BASE_PATH}/${MODEL_NAME} --model_config_file=${MODEL_CONFIG_FILE} "$@"' > usr/bin/tf_serving_entrypoint.sh
ENTRYPOINT tensorflow_model_server --port=8500 --rest_api_port=8501 --model_config_file=/models/model_config --model_config_file_poll_wait_seconds=60 
