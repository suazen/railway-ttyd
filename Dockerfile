FROM tsl0922/ttyd:latest

# Install nginx
RUN apt-get update && apt-get install -y nginx

# Configure nginx to proxy ttyd to /shell
RUN echo "server { \
    listen 80; \
    location ~ ^/ttyd(.*)$ { \
        proxy_http_version 1.1; \
        proxy_set_header Host $host; \
        proxy_set_header X-Forwarded-Proto $scheme; \
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; \
        proxy_set_header Upgrade $http_upgrade; \
        proxy_set_header Connection "upgrade"; \
        proxy_pass http://127.0.0.1:7681/$1; \
    }
}" > /etc/nginx/sites-enabled/default

# Start nginx and ttyd
CMD service nginx start && ttyd bash
