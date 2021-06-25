FROM triple3a/laravel-ci AS builder

COPY . /var/www/html
ENV COMPOSER_MEMORY_LIMIT=-1
RUN mkdir -p /var/www/html/storage/framework/sessions \
    && mkdir -p /var/www/html/storage/framework/views \
    && mkdir -p /var/www/html/storage/framework/cache \
    && mkdir -p /var/www/html/storage/framework/cache/data \
    && chmod -R 777 /var/www/html/storage/framework \
    && chown -R www-data:www-data /var/www/html/storage/framework \
    && composer update

FROM triple3a/laravel
COPY --from=builder /var/www/html /var/www/html
ENTRYPOINT /docker-entrypoint.sh
