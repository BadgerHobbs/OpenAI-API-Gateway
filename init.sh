#!/bin/sh

# Substitute environment variables
envsubst '${GATEWAY_API_KEY},${OPENAI_API_KEY},${OPENAI_API_HOST},${AZURE_OPENAI_API},${RATE_LIMIT}' < /etc/nginx/conf.d_template/default.conf > /etc/nginx/conf.d/default.conf

# Start nginx
exec "nginx" "-g" "daemon off;"