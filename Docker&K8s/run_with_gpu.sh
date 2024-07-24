#Make this file executable
#chmod +x run_with_gpu.sh

#How to use?
#./run_with_gpu.sh <docker-image-name>
#./run_with_gpu.sh <docker-image-name> <container-name>
#./run_with_gpu.sh <docker-image-name> <container-name> <path-to-shared-folder>

#TODO ./run_with_gpu.sh ubuntu-20.04:1 linuxos_koneneros /Home/opszalek/Nauka fix errors
# Parameters
IMAGE_NAME=$1
# Set default container name if not provided
CONTAINER_NAME=${2:-"${IMAGE_NAME}_container"} 
SHARED_FOLDER_PATH=$3


#Allowing access to X server so you can use GUI apps in container
xhost +local:root              

# Setup Docker Xauth to allow X11 forwarding
XAUTH=/tmp/.docker.xauth
if [ ! -f $XAUTH ]
then
    xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
    if [ ! -z "$xauth_list" ]
    then
        echo $xauth_list | xauth -f $XAUTH nmerge -
    else
        touch $XAUTH
    fi
    chmod a+r $XAUTH
fi

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
    /bin/bash"

# Conditionally add shared folder if provided
if [ -n "$SHARED_FOLDER_PATH" ]
then
    docker_cmd+=" --volume=\"$SHARED_FOLDER_PATH:/workspace:rw\""
fi

# Execute the Docker command
eval $docker_cmd
