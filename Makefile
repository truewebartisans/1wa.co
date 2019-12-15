.PHONY: build

build:
	cd web \
	&& npm run build:prod \
	&& cd .. \
	&& rm ./http_server_1wa \
	&& pkger \
	&& go build -o ./http_server_1wa
	@echo "[✔️] App build complete!"

backend:
	pkger \
	&& go run ./main.go
	@echo "[✔️] App backend is running!"

frontend:
	cd web \
	&& npm start
	@echo "[✔️] App frontend is running!"
