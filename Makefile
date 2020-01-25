.PHONY: build

build:
	@cd frontend && npm run build:prod
	@echo "[✔️] App build complete!"

run:
	@cd frontend && npm start
	@echo "[✔️] App frontend is running!"
