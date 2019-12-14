.PHONY: run

default: run

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
	&& rm ./http_server_1wa \
	&& pkger \
	&& go build -o ./http_server_1wa
	@echo "[✔️] App build complete!"
