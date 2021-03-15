#!/bin/bash

# CHANGE
CLOUDRUN_URL="https://kfpdemo-zp62h7f6ra-uc.a.run.app"



# test cloud run
CLOUDRUN_URL="https://kfpdemo-zp62h7f6ra-uc.a.run.app"
echo "Invoking ${CLOUDRUN_URL}"
curl \
   --header "Authorization: Bearer $(gcloud auth print-identity-token)" \
   --header "Content-Type: application/json" \
   --request POST \
   --data '{"bucket":"cesar-pipelines-kfp","filename":"babyweight/preproc/train_2000.csv-00015-of-00020"}' \
   ${CLOUDRUN_URL}

