# Use an official Ubuntu as a parent image
FROM ubuntu:20.04

# Set non-interactive installation mode
ENV DEBIAN_FRONTEND=noninteractive

# Update apt packages and install software
RUN apt-get update && \
    apt-get install -y \
    git \
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
