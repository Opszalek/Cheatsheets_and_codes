#!/bin/bash

#Starts a Docker container with GPU and X11 support, stopping any existing container with the same name.

#Make this file executable
#chmod +x run_with_gpu.sh

#How to use?
#./run_with_gpu.sh <docker-image-name:image-tag>
#./run_with_gpu.sh <docker-image-name:image-tag> <container-name>
#./run_with_gpu.sh <docker-image-name:image-tag> <container-name> <path-to-shared-folder>

#TODO ./run_with_gpu.sh ubuntu-20.04:1 linuxos_koneneros /Home/opszalek/Nauka fix errors
# Parameters
IMAGE_NAME=$1
# Set default container name if not provided
clean_image_name="${IMAGE_NAME%%:*}" # Deleting tag because it causes errors
CONTAINER_NAME=${2:-"${clean_image_name}-container"}
SHARED_FOLDER_PATH=$3

echo $CONTAINER_NAME

#Allowing access to X server so you can use GUI apps in container
xhost +local:root              

# Setup Docker Xauth to allow X11 forwarding
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -


# Stop and remove the old container
docker stop $CONTAINER_NAME || true && docker rm $CONTAINER_NAME || true

# Run the Docker container
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
    $IMAGE_NAME \
    "

# Conditionally add shared folder if provided
if [ -n "$SHARED_FOLDER_PATH" ]
then
     docker_cmd="${docker_cmd} --volume=\"${SHARED_FOLDER_PATH}:/workspace:rw\""
fi
docker_cmd="${docker_cmd} \"/bin/bash\""
# Execute the Docker command
eval $docker_cmd
