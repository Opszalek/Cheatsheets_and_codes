#!/bin/bash

#Manages a Docker container: starts a new one if none exists, starts if stopped, and enters if running.

#Make this file executable
#chmod +x run_with_gpu.sh

# Usage:
# ./enter_with_gpu.sh <docker-image-name:image-tag>
# ./enter_with_gpu.sh <docker-image-name:image-tag> <container-name>
# ./enter_with_gpu.sh <docker-image-name:image-tag> <container-name> <path-to-shared-folder>

# Parameters
IMAGE_NAME=$1
# Set default container name if not provided
clean_image_name="${IMAGE_NAME%%:*}" # Deleting tag because it causes errors
CONTAINER_NAME=${2:-"${clean_image_name}-container"}
SHARED_FOLDER_PATH=$3
echo $CONTAINER_NAME

# Function to check if the container is running
is_container_running() {
    docker ps --filter "name=$CONTAINER_NAME" --filter "status=running" -q
}

# Function to check if the container exists (but not necessarily running)
is_container_existing() {
    docker ps -a --filter "name=$CONTAINER_NAME" -q
}

# If no container exists, create and start a new one
if [ -z "$(is_container_existing)" ]; then
    echo "No existing container found. Creating and starting a new one..."

    # Allowing access to X server so you can use GUI apps in container
    xhost +local:root              

    # Setup Docker Xauth to allow X11 forwarding
    XSOCK=/tmp/.X11-unix
    XAUTH=/tmp/.docker.xauth
    touch $XAUTH
    xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

    # Build Docker command
    docker_cmd="docker run -it \
        --gpus all \
        --workdir=\"/workspace\" \
        --env=\"DISPLAY=$DISPLAY\" \
        --env=\"QT_X11_NO_MITSHM=1\" \
        --volume=\"/tmp/.X11-unix:/tmp/.X11-unix:rw\" \
        --env=\"XAUTHORITY=$XAUTH\" \
        --volume=\"$XAUTH:$XAUTH\" \
        --env=\"NVIDIA_VISIBLE_DEVICES=all\" \
        --env=\"NVIDIA_DRIVER_CAPABILITIES=all\" \
        --privileged \
        --network=host \
        --name=\"$CONTAINER_NAME\" \
        $IMAGE_NAME"

    # Conditionally add shared folder if provided
    if [ -n "$SHARED_FOLDER_PATH" ]; then
        docker_cmd="${docker_cmd} --volume=\"${SHARED_FOLDER_PATH}:/workspace:rw\""
    fi
    docker_cmd="${docker_cmd} \"/bin/bash\""

    # Execute the Docker command
    eval $docker_cmd

# If container exists but is not running, start it and then enter
elif [ -z "$(is_container_running)" ]; then
    echo "Existing container found but it is not running. Starting the container..."
    docker start $CONTAINER_NAME
    docker exec -it $CONTAINER_NAME /bin/bash

# If container is running, enter it
else
    echo "Container is already running. Entering the container..."
    docker exec -it $CONTAINER_NAME /bin/bash
fi

