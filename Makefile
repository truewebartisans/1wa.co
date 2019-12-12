.PHONY: run

run:
	pkger \
	&& go run ./main.go
	@echo "[✔️] App is running!"

front:
	cd web \
	&& npm run build:prod
	@echo "[✔️] Frontend build complete!"

build:
	cd web \
	&& npm run build:prod \
	&& cd .. \
	&& rm -rf ./deploy \
	&& mkdir -p ./deploy \
	&& go build -o ./deploy/http_server_1wa
	@echo "[✔️] App build complete!"
