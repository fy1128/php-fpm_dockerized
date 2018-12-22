FROM php:7.2-fpm-alpine
RUN set -eux; \
	\
	buildDeps=' \
	        freetype-dev \
	        libjpeg-turbo-dev \
	        libpng-dev \
		build-base \
	'; \
	runDeps=' \
		libpng \
		libjpeg-turbo \
		freetype \
	'; \
	apk add --no-cache --virtual .build-deps \
		$buildDeps \
	; \
	\
	docker-php-ext-install -j$(nproc) iconv; \
	docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/; \
	docker-php-ext-install -j$(nproc) gd; \
	docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd; \
	docker-php-ext-install -j$(nproc) pdo_mysql; \
	apk add --no-cache --virtual .run-deps \
		$runDeps \
	; \
	apk del .build-deps; 

