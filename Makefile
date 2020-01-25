.PHONY: build

build:
	@cd frontend && npm run build:prod
	@echo "[✔️] App build complete!"

run:
	@cd frontend && npm start

certbot-test:
	@cd webserver
	@chmod +x ./register_ssl_for_domain.sh
	@./register_ssl_for_domain.sh \
								--domains "1wa.co www.1wa.co" \
								--email truewebartisans@gmail.com \
								--data-path ./certbot \
								--staging 1

certbot:
	@cd webserver
	@chmod +x ./register_ssl_for_domain.sh
	@./register_ssl_for_domain.sh \
								--domains "1wa.co www.1wa.co" \
								--email truewebartisans@gmail.com \
								--data-path ./certbot \
								--staging 0

deploy-test:
	@docker-compose \
					-f docker-compose.yml \
					-f docker-compose.prod.yml \
					up --build --force-recreate

deploy:
	@docker-compose \
					-f docker-compose.yml \
					-f docker-compose.prod.yml \
					up -d --build --force-recreate
