#!/bin/bash

source /home/infosecfall2025/config.env

gcloud functions deploy "$FUNCTION_NAME" \
    --project "$PROJECT_ID" \
    --region "$REGION" \
    --runtime python310 \
    --trigger-http \
    --allow-unauthenticated \
    --quiet 

