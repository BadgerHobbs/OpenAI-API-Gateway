#!/bin/sh

# Substitute environment variables
envsubst '${GATEWAY_API_KEY},${OPENAI_API_KEY},${OPENAI_API_HOST},${AZURE_OPENAI_API},${RATE_LIMIT},${CLIENT_MAX_BODY_SIZE},${CORS_ORIGIN},${CORS_METHODS},${CORS_HEADERS},${CORS_CREDENTIALS},${CORS_MAX_AGE},${CONTENT_LENGTH},${CONTENT_TYPE}' < /etc/nginx/conf.d_template/default.conf > /etc/nginx/conf.d/default.conf

# Start nginx
exec "nginx" "-g" "daemon off;"
