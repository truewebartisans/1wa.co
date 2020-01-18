.PHONY: build

build:
	@cd web && npm run build:prod
	@cd .. && rm -rf ./build
	@pkger && go build -o ./build/http_server_1wa ./...
	@echo "[✔️] App build complete!"

backend:
	@pkger && go run ./...
	@echo "[✔️] App backend is running!"

frontend:
	@cd web && npm start
	@echo "[✔️] App frontend is running!"
