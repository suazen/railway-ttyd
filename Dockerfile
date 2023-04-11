FROM tsl0922/ttyd:latest

# Install nginx
RUN apt-get update && apt-get install -y nginx

# Configure nginx to proxy ttyd to /shell
COPY nginx.conf /etc/nginx/conf.d/ttyd.conf

# Start nginx and ttyd
CMD service nginx start && ttyd bash
