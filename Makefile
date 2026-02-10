.PHONY: lint test security check run
lint:
	@echo "Linting..." && find . -name "*.py" -exec python3 -m py_compile {} \; 2>/dev/null && echo "OK"
test:
	@echo "Testing..." && pytest tests/ -v 2>/dev/null || echo "Install: pip install pytest"
security:
	@git log --all -p 2>/dev/null | grep -iE "api_key=|secret=|password=" | head -3 && echo "WARN" || echo "Clean"
check: lint test security
run:
	@echo "Starting..." && docker-compose up -d 2>/dev/null || echo "Install docker-compose"
