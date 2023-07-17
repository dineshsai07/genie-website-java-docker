# Use the official Ubuntu base image
FROM ubuntu

# Update the package lists
RUN apt-get update

# Install NGINX
RUN apt-get install -y nginx
