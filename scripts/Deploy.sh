#!/bin/bash

# Variables
REPOSITORY_URI=752023216802.dkr.ecr.us-east-1.amazonaws.com/dotnet
IMAGE_TAG=$(cat /home/ec2-user/docker-app/imagedefinitions.json | jq -r '.[0].imageUri')

# Stop and remove any existing container
docker stop aspnet-core-dotnet-core || true
docker rm aspnet-core-dotnet-core || true

# Pull the new image from ECR
$(aws ecr get-login --no-include-email --region us-east-1)
docker pull $IMAGE_TAG

# Run the new container
docker run -d --name aspnet-core-dotnet-core -p 80:80 $IMAGE_TAG
