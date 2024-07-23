##############################################################################
# DOCKER BASICS
##############################################################################
#host ports:containter ports

docker build -t image_name .                # Create image using Dockerfile from current dict
docker run -p 4000:80 image_name            # Run image "image_name" mapping port 4000 to 80
docker run -d -p 4000:80 image_name         # Same thing, but in detached mode
docker exec -it <container-id> bash         # Enter a running container
docker stop <container-id>                  # Stop a specific container
docker ps -a                                # List all containers (running and stopped)
docker ps                                   # List all running containers
docker image ls                             # List Docker images
docker rm <container-id>                    # Remove one or more containers
docker image rm <image-name>                # Remove one or more images
docker stats                                # Display a live stream of container resource usage statistics
docker top <container-id>                   # Display the running processes of a specified container
docker rm -f <container-id>                 # Forcefully remove a container
docker rmi <image-id>                       # Remove one or more specific images
docker rmi $(docker images -q)              # Remove all images
docker login                                # Log in to a Docker registry (public or private)
docker logs <container-id> -f               # Follow log output for a specified container
docker kill <container-id>                  # Kill one or more running containers
docker system prune                         # Remove all stopped containers, unused networks, and dangling images
docker system prune -a                      # Remove all stopped containers, unused networks, and all unused images (not just dangling ones)
docker volume prune                         # Remove all unused volumes
docker network prune                        # Remove all unused networks
docker run -v /host/path:/container/path <image> # Run a container with a bind mount volume
docker run --network <network-name> <image> # Run a container within a specified network
docker run --restart=always -d <image-name> # Run a container with a restart policy set to always
docker run --read-only -d <image-name>      # Run a container with a read-only filesystem
docker save -o <path-for-tar>/<image-name>.tar <image-name> # Save an image to a tar archive
docker load -i <path-for-tar>/<image-name>.tar # Load an image from a tar archive
docker scan <image-name>  					# Scan the Docker image for vulnerabilities

##############################################################################
# DOCKER COMPOSE
##############################################################################

docker compose up                            # Build and start your containers from the Docker Compose file
docker compose up -d                         # Start services defined in the docker-compose.yml in detached mode
docker compose down                          # Stop and remove containers, networks, images
docker compose down -v                       # Stop and remove containers, network and volumes
docker compose logs                          # View output from containers
docker compose ps                            # List containers
docker compose exec <service-name> <command> # Execute a command in a running container
docker compose restart                       # Restart services defined in the default docker-compose.yml
docker compose -f myconfig.yml up            # Start services using the 'myconfig.yml' file instead of the default
docker compose down -rmi all                 # Remove all images used by any service
docker compose down -rmi local               # Remove only local images (not pulled from a registry) used by any service
docker compose up -d --scale <service-name>=<number> # Start and scale service to n instances in detached mode
docker compose config                        # Validate and view the docker-compose.yml file's configuration
docker compose build                         # Build or rebuild services associated with the docker-compose.yml
docker compose top                           # Display the running processes of containers managed by docker-compose

##############################################################################
# DOCKER SWARM
##############################################################################

docker swarm init                          	 	    # Initialize a swarm
docker node ls                              		# List nodes in the swarm
docker service create --name <service-name> <image> # Create a service
docker service ls                           		# List services
docker service ps                                   # List the tasks
docker service scale <service-name>=<replicas> 		# Scale a service
docker service rm <service-name>            		# Remove a service
docker service update <options> <service-name> 		# Update Service options
docker service inspect --pretty <service-name>      # Display detailed information Service
docker node inspect <manager-node-name> --format "{{ .ManagerStatus.Reachability }}" # Inspect the reachability of a manager node
docker node inspect <node-name> --format "{{ .Status.State }}" # Inspect the current state of a node
docker node update --label-rm <key> <node-name>     # Remove a label from a node
docker node inspect <node-name> | grep Labels -C5   # Display labels for a node with context
docker stack deploy -c <docker-compose.yml> <stack-name> # Deploy or update a stack using a compose file
docker stack ls                                     # List all stacks
docker stack rm <stack-name>                        # Remove a stack
docker stack services <stack-name>                  # List services in a stack
docker service logs <service-name>                  # Fetch the logs of a service

##############################################################################
# DOCKER NETWORKS
##############################################################################

docker network ls                           # List networks
docker network create --driver <driver> <network-name> # Create a network
docker network inspect <network-name>       # Inspect a network
docker network rm <network-name>            # Remove a network
docker network connect <network-name> <container-name> # Connect a container to a network
docker network disconnect <network-name> <container-name> # Disconnect a container from a network
docker container run -d --name <container-name> --network <network-name> <image> # Starts container with network
docker run --network host <image-name>		# Run container with host network


##############################################################################
# DOCKER VOLUMES
##############################################################################

docker volume create <volume-name>          # Create a volume
docker volume ls                            # List volumes
docker volume inspect <volume-name>         # Inspect a volume
docker volume rm <volume-name>              # Remove a volume

