FROM node:14-slim

# Install dependen
RUN apt-get update \
    && apt-get install -y wget gnupg ca-certificates \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Set the Puppeteer environment variables
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome-stable

# Set the container to run with the unprivileged user
USER node

# Set up the app directory
WORKDIR /usr/bluepen-capture-server

# Copy app source
COPY . .

# Install dependencies
RUN sudo npm install -g --unsafe-perm=true --allow-root

# Add additional flags and configurations when launching Puppeteer
ENV PUPPETEER_ARGS="--no-sandbox --disable-setuid-sandbox --disable-dev-shm-usage --disable-namespace-sandbox"

EXPOSE 3000

CMD [ "npm", "start" ]


# # FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
# # WORKDIR /app
# # EXPOSE 80
# EXPOSE 443


# # Use Amazon Linux as the base image
# FROM amazonlinux:latest

# # Install Apache HTTP Server
# RUN yum update -y && \
#     yum install -y httpd && \
#     yum clean all

# # Expose port 80 to allow incoming HTTP traffic
# EXPOSE 80

# # Start Apache HTTP Server in the foreground
# CMD ["httpd", "-D", "FOREGROUND"]

