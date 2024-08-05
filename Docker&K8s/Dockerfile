#Usage
#docker build -t your_image_name:your_tag .


# Use an official Ubuntu as a parent image
FROM ubuntu:20.04


# Set enviroment variable
# Set non-interactive installation mode
ENV DEBIAN_FRONTEND=noninteractive
# Set nvidia params so every container you run will have acces to graphics card (remember to install NVIDIA Container Toolkit before) and restart docker deamon after 
#sudo systemctl restart docker
ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

# Update apt packages and install software
# It is good habbit to get all packages in one command because you are updading just before downloading
RUN apt-get update && \
    apt-get install -y \
    git \
    xauth \
    curl \
    vim && \
    # Clean up to reduce layer size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /workspace

# Copy the current directory contents into the container at /workspace
COPY . /workspace

# Expose port 80 for service availability
EXPOSE 80

# Define the command to run on container start
CMD ["bash"]

# Define a mount point for external volumes
VOLUME /data
