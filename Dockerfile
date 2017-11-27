FROM alpine:3.6

# Install/Update NGINX
RUN apk add --update nginx && rm -rf /var/cache/apk/*

# Copy NGINX configuration files
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Copy portfolio website static files
COPY portfolio /usr/share/nginx/html

# Start NGINX in foreground
CMD ["nginx", "-g", "daemon off;"]
