# OpenAI-API-Gateway

## Overview

The OpenAI-API-Gateway is a simple NGINX web server which acts as a proxy, forwarding OpenAI API requests from the client. It is configured to accept a gateway API key from the client for gateway authentication. The OpenAI API key is then set on all requests made to OpenAI, meaning the client never has access to it.

The OpenAI-API-Gateway supports both custom API servers using API key Authorization headers, as well as the Azure OpenAI API service. Both are configurable via environment variables.

![diagram](https://github.com/BadgerHobbs/OpenAI-API-Gateway/assets/23462440/e5444282-275d-4b44-99d1-8a65c685a6d9)

## Setup

The sections below detail how to configure and deploy the OpenAI-API-Gateway, with examples for both the OpenAI and Azure OpenAI APIs.

### Configuration

Below are the various environment variables used to configure the OpenAI-API-Gateway.

| Variable | Default Value | Required/Optional |
| --- | --- | --- |
| `GATEWAY_API_KEY` | `null` | `Required` |
| `OPENAI_API_KEY` | `null` | `Required` |
| `OPENAI_API_HOST` | `https://api.openai.com` | `Optional` |
| `RATE_LIMIT` | `20r/m` | `Optional` |

### Docker Deployment

#### Docker Run Command

Below are example docker run commands for deploying the OpenAI-API-Gateway to work with the OpenAI and Azure OpenAI APIs.

##### OpenAI API
```sh
docker run -d \
    --name openai-api-gateway \
    -p 80:80 \
    -e GATEWAY_API_KEY=super_secret_api_key \       # Required
    -e OPENAI_API_KEY=your_api_key_here \           # Required
    -e OPENAI_API_HOST=https://api.openai.com \     # Optional
    -e RATE_LIMIT=20r/m \                           # Optional
    ghcr.io/badgerhobbs/openai-api-gateway:main
```

##### Azure OpenAI API
```sh
docker run -d \
    --name azure-openai-api-gateway \
    -p 80:80 \
    -e GATEWAY_API_KEY=super_secret_api_key \                               # Required
    -e OPENAI_API_KEY=your_api_key_here \                                   # Required
    -e OPENAI_API_HOST=https://my-azure-openai-api.openai.azure.com \       # Required
    -e RATE_LIMIT=20r/m \                                                   # Optional
    ghcr.io/badgerhobbs/openai-api-gateway:main
```

#### Docker Compose

The following is an example docker compose file for deploying gateways for both the OpenAI and Azure OpenAI API.

```yaml
version: '3'
services:

  openai-api-gateway:
    image: ghcr.io/badgerhobbs/openai-api-gateway:main
    container_name: openai-api-gateway
    ports:
      - 80:80
    environment:
      - GATEWAY_API_KEY=super_secret_api_key                               # Required
      - OPENAI_API_KEY=your_api_key_here                                   # Required
      - OPENAI_API_HOST=https://api.openai.com                             # Optional
      - RATE_LIMIT=20r/m                                                   # Optional
    restart: unless-stopped

  azure-openai-api-gateway:
    image: ghcr.io/badgerhobbs/openai-api-gateway:main
    container_name: azure-openai-api-gateway
    ports:
      - 80:80
    environment:
      - GATEWAY_API_KEY=super_secret_api_key                               # Required
      - OPENAI_API_KEY=your_api_key_here                                   # Required
      - OPENAI_API_HOST=https://my-azure-openai-api.openai.azure.com       # Required
      - RATE_LIMIT=20r/m                                                   # Optional
    restart: unless-stopped
```

```sh
docker compose -p "openai-api-gateway" up -d
```

### Docker Image Build (Optional)
You can build your own docker image of the OpenAI-API-Gateway with the following command.

```sh
docker build -t openai-api-gateway .
```

## Example Usage

Below are example cURL requests for OpenAI and Azure OpenAI queries.

### OpenAI API cURL Request

With the OpenAI-API-Gateway hosted locally, you can make a request to the OpenAI API using cURL with a command similar to the following.

```sh
curl http://localhost:80/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer super_secret_api_key" \
  -d '{
    "model": "gpt-3.5-turbo",
    "messages": [
      {
        "role": "system",
        "content": "You are a helpful assistant."
      },
      {
        "role": "user",
        "content": "Hello!"
      }
    ]
  }'
```

### OpenAI API Curl Request

With the OpenAI-API-Gateway hosted locally, you can make a request to the Azure OpenAI API using cURL with a command similar to the following.

```sh
curl http://localhost:80/openai/deployments/gpt-35-turbo/chat/completions?api-version=2023-05-15 \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer super_secret_api_key" \
  -d '{
    "messages": [
      {
        "role": "system",
        "content": "You are a helpful assistant."
      },
      {
        "role": "user",
        "content": "Hello!"
      }
    ]
  }'
```

## License

The code and documentation in this project are released under the [GPLv3 License](LICENSE).
