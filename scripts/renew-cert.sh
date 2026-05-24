#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/.."

docker run --rm \
  -v "$(pwd)/certbot/conf:/etc/letsencrypt" \
  -v "$(pwd)/certbot/www:/var/www/certbot" \
  certbot/certbot renew --webroot --webroot-path=/var/www/certbot

docker compose exec nginx nginx -s reload