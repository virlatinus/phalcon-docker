#!/bin/sh

# download and install composer in global composer dir
curl -Lso- https://getcomposer.org/installer | php -- --install-dir=~/.composer/vendor/bin --filename=composer

export PATH=$PATH:~/.composer/vendor/bin

# install phalcon devtools
composer global require phalcon/devtools
