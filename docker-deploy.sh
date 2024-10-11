#!/bin/bash

# 1. Stop and remove all containers using the vi-biz-api image
echo "Stopping and removing all containers using the vi-biz-api image..."
docker ps -a --filter "ancestor=vi-biz-api" --format "{{.ID}}" | while read -r container_id; do
    echo "Stopping container $container_id..."
    docker stop "$container_id"
    echo "Removing container $container_id..."
    docker rm "$container_id"
done

# 2. Find the latest vi-biz-api tar file (based on timestamp in filename)
echo "Searching for the latest vi-biz-api tar file..."
LATEST_TAR=$(ls -t ~/vi-api/images/*.tar | head -n 1)

if [ -z "$LATEST_TAR" ]; then
    echo "No .tar files found."
    exit 1
else
    echo "Found latest .tar file: $LATEST_TAR"
fi

# 3. Load the latest image from the tar file
echo "Loading the latest Docker image from $LATEST_TAR..."
docker load -i "$LATEST_TAR"

# 4. Run a new container from the loaded image
echo "Running a new container from the vi-biz-api image..."
docker run -d \
    --env-file ~/vi-api/.env \
    -p 8000:8000 \
    -v ~/vi-api/app-db:/vi_biz/appdb \
    vi-biz-api

echo "Container started successfully."

