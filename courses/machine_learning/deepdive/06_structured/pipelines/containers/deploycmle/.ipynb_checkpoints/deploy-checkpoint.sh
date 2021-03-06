#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: ./deploy.sh  modeldir  modelname  modelversion"
    exit
fi

MODEL_LOCATION=$(gsutil ls $1/export/exporter | tail -1)
MODEL_NAME=$2
MODEL_VERSION=$3

TFVERSION=1.15
REGION=us-central1

# create the model if it doesn't already exist
modelname=$(gcloud ai-platform models list | grep -w "$MODEL_NAME")
echo $modelname
echo "Going to deploy version $TFVERSION"
if [ -z "$modelname" ]; then
   echo "Creating model $MODEL_NAME"
   gcloud ai-platform models create ${MODEL_NAME} --regions $REGION
else
   echo "Model $MODEL_NAME already exists"
fi

# delete the model version if it already exists
modelver=$(gcloud ai-platform versions list --model "$MODEL_NAME" --region global | grep -w "$MODEL_VERSION")
echo $modelver
if [ "$modelver" ]; then
   echo "Deleting version $MODEL_VERSION"
   yes | gcloud ai-platform versions delete ${MODEL_VERSION} --model ${MODEL_NAME} --region global
   sleep 10
fi


echo "Creating version $MODEL_VERSION from $MODEL_LOCATION"
echo "Lauching command"
echo "gcloud ai-platform versions create $MODEL_VERSION --model $MODEL_NAME --origin $MODEL_LOCATION --runtime-version $TFVERSION --region global"
gcloud ai-platform versions create ${MODEL_VERSION} --model ${MODEL_NAME} --origin ${MODEL_LOCATION} --runtime-version ${TFVERSION} --region global


echo $MODEL_NAME > /model.txt
echo $MODEL_VERSION > /version.txt

