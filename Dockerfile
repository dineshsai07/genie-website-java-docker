# Use the official Ubuntu base image
FROM ubuntu

# Update the package lists
RUN apt-get update

# hjh NG
RUN apt-get install -y nginx
