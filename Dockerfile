# Use the official Ubuntu base image
FROM ubuntu

# Update the package lists
RUN apt-get update

# Install NGINX
RUN apt-get install -y nginx

# Copy custom configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start NGINX when the container launches
CMD ["nginx", "-g", "daemon off;"]
