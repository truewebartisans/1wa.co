.PHONY: run

run:
	pkger \
	&& go run ./main.go
	@echo "[✔️] App is running!"

init:
	cd web \
	&& npm install \
	&& npm start
	@echo "[✔️] Init complete!"

build:
	cd web \
	&& npm run build:prod \
	&& cd .. \
	&& rm -rf ./deploy \
	&& mkdir -p ./deploy \
	&& go build -o ./deploy/http_server_1wa
	@echo "[✔️] Build complete!"
