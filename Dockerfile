FROM nginx:latest

# Default environment variable values
ENV OPENAI_API_HOST=https://api.openai.com
ENV AZURE_OPENAI_API=False
ENV RATE_LIMIT=20r/m

# Copy gateway configuration
COPY gateway-nginx.conf /etc/nginx/conf.d_template/default.conf

# Copy and run init script to inject environment variables into configuration and run nginx
COPY init.sh /docker-entrypoint.d/init.sh
RUN chmod +x /docker-entrypoint.d/init.sh