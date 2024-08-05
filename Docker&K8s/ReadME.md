Example usage:

Build image: docker build -t ubuntu-20.04:1 . 

Run container: ./run_with_gpu.sh ubuntu-20.04:1 ubuntu20 #Stops and remove old one

OR: ./enter_with_gpu.sh ubuntu-20.04:1 ubuntu20 #Keeps old one and enter it

If no longer needed:

Delete container: docker rm ubuntu20

Delete image: docker rmi ubuntu-20.04:1






--error

xauth:  /tmp/.docker.xauth not writable, changes will be ignored

chmod: changing permissions of '/tmp/.docker.xauth': Operation not permitted

--fix

sudo chown $USER:$USER /tmp/.docker.xauth

sudo chmod 644 /tmp/.docker.xauth
