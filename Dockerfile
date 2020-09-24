FROM mileschou/phalcon:7.4-fpm-alpine

# Necessary for phalcon-tools to manage models and DB tasks
RUN docker-php-ext-install pdo_mysql
