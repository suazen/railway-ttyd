FROM tsl0922/ttyd:latest

# Install nginx
RUN apt-get update && apt-get install -y nginx

# Configure nginx to proxy ttyd to /shell
RUN echo "server { \
    listen 80; \
    location /shell { \
        proxy_pass http://localhost:7681; \
        proxy_http_version 1.1; \
        proxy_set_header Upgrade \$http_upgrade; \
        proxy_set_header Connection "Upgrade"; \
        proxy_set_header Host \$host; \
    } \
}" > /etc/nginx/sites-available/default

# Start nginx and ttyd
CMD service nginx start && ttyd bash
