FROM node:16-alpine AS builder
WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
ENV GENERATE_SOURCEMAP=false
RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
RUN printf 'server {\n\
    listen 80;\n\
    server_name _;\n\
    root /usr/share/nginx/html;\n\
    index index.html;\n\
    location / {\n\
        try_files $uri $uri/ /index.html;\n\
    }\n\
}\n' > /etc/nginx/conf.d/default.conf
EXPOSE 80
HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD wget --no-verbose --tries=1 --spider http://localhost/ || exit 1
CMD ["nginx", "-g", "daemon off;"]
