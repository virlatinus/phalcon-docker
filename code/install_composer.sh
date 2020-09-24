#!/bin/sh

# download and install composer in global composer dir
curl -Lso- https://getcomposer.org/installer | php -- --install-dir=~/.composer/vendor/bin --filename=composer

export PATH=$PATH:~/.composer/vendor/bin

# install phalcon devtools globally
composer global require phalcon/devtools

# install phpunit globally
composer global require phpunit/phpunit:^9.0

if [ -d store ]; then
		cd store

		# install phalcon migrations
		composer require --dev phalcon/migrations
    
		composer require --dev phpunit/phpunit:^9.0

		composer require --dev phalcon/incubator-test:^v1.0.0-alpha.1
fi
