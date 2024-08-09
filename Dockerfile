# syntax=docker/dockerfile:1

# Build the composer dependencies
FROM composer:2.7.7 AS composer
WORKDIR /app
COPY . ./
RUN composer install --no-dev --no-interaction --no-progress --no-suggest && \
    composer cache

# Build the final image
FROM composer/satis:latest
WORKDIR /app
COPY --from=composer /app /app

CMD ["php", "/satis/bin/satis", "build", "/app/satis.json", "/app/docs"]
