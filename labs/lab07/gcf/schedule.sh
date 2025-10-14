#!/bin/bash

gcloud scheduler jobs create http mail-job \
    --location europe-west1 \
    --schedule "* * * * *" \
    --uri "https://europe-west1-infoseclab07.cloudfunctions.net/main" \
    --http-method GET 
