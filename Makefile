docker-start: docker-login docker-configure
	composer install

docker-login:
	@echo "--> Login to Github"
	docker login https://github.com/joris-pothin/cfr-esport

docker-configure: configure-hosts docker-up
	mysql -h service.mysql -u root -proot < ./scripts/init-databases.sql
	bash ./scripts/init-directories.sh
# 	docker run -d php:7.3-fpm
# 	docker-compose run engine bash -c "stow -D -R --dir=config-dist --target=."

docker-up:
	docker-compose up --build -d

docker-clean:
	docker system prune -a -f

docker-down:
	docker-compose down

docker-reset: docker-down docker-clean docker-start

configure-hosts:
	bash ./scripts/init-hosts.sh

# TODO
docker-publish: docker-login
	@echo "--> Re-building PHP-FPM Docker image"
	docker build -t https://github.com/joris-pothin/cfr-esport/php-fpm ./docker/engine/
	@echo "--> Pushing image to repository"
	docker push https://github.com/joris-pothin/cfr-esport/php-fpm
