FROM tsl0922/ttyd:latest

# Install nginx
RUN apk update && apk add nginx

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
}" > /etc/nginx/conf.d/default.conf

# Start nginx and ttyd
CMD nginx && ttyd bash
