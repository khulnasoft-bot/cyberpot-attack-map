# Makefile for CyberPot Attack Map

PYTHON = python3
PIP = pip3

.PHONY: help install run-map run-data update-hashes check-hashes lint test clean

help:
	@echo "Usage:"
	@echo "  make install         Install dependencies"
	@echo "  make run-map         Start the Attack Map Server (Websocket/Static)"
	@echo "  make run-data        Start the Data Server (ES to Redis)"
	@echo "  make update-hashes   Update integrity hashes in index.html"
	@echo "  make check-hashes    Check integrity hashes without updating"
	@echo "  make lint            Run flake8 for code linting"
	@echo "  make test            Run tests"
	@echo "  make clean           Clean up temporary files"

install:
	$(PIP) install -r requirements.txt

run-map:
	$(PYTHON) AttackMapServer.py

run-data:
	$(PYTHON) DataServer.py

update-hashes:
	$(PYTHON) update_hashes.py

check-hashes:
	$(PYTHON) update_hashes.py --check

lint:
	@if command -v flake8 > /dev/null; then \
		flake8 *.py; \
	else \
		echo "flake8 not found, please install it with 'pip install flake8'"; \
	fi

test:
	@if command -v pytest > /dev/null; then \
		pytest; \
	else \
		echo "pytest not found, please install it with 'pip install pytest'"; \
	fi

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
