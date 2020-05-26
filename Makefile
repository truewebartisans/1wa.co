.PHONY: run

run:
	@cd frontend && npm start

certbot-test:
	@chmod +x ./webserver/register_ssl_for_domain.sh
	@./webserver/register_ssl_for_domain.sh \
								--domains "1wa.co www.1wa.co" \
								--email truewebartisans@gmail.com \
								--data-path ./webserver/certbot \
								--staging 1

certbot-prod:
	@chmod +x ./webserver/register_ssl_for_domain.sh
	@./webserver/register_ssl_for_domain.sh \
								--domains "1wa.co www.1wa.co" \
								--email truewebartisans@gmail.com \
								--data-path ./webserver/certbot \
								--staging 0

deploy-test:
	@docker-compose \
					-f docker-compose.yml \
					-f docker-compose.prod.yml \
					up --build --force-recreate

deploy-prod:
	@docker-compose \
					-f docker-compose.yml \
					-f docker-compose.prod.yml \
					up -d --build --force-recreate
