# Makefile for ccutils
# =========================================
# ccutils - Makefile
# =========================================
SHELL := /bin/bash

PYTHON := python3
VENV_DIR = .venv

# Paths
SRC_DIR := src
TEST_DIR := tests
SPHINX_DIR = docs/sphinx
JEKYLL_DIR = docs/jekyll
SPHINX_BUILD_DIR = $(SPHINX_DIR)/_build/html
JEKYLL_OUTPUT_DIR = $(JEKYLL_DIR)/sphinx

# dependencies
DEPS := .
DEV_DEPS := .[dev]

# Python Commands
CREATE_VENV := $(PYTHON) -m venv $(VENV_DIR)
ACTIVATE = source $(VENV_DIR)/bin/activate
PIP := $(ACTIVATE) && $(PYTHON) -m pip
RUFF := $(ACTIVATE) && $(PYTHON) -m ruff
MYPY := $(ACTIVATE) && $(PYTHON) -m mypy
PYTEST := $(ACTIVATE) && $(PYTHON) -m pytest
SPHINX := $(ACTIVATE) && $(PYTHON) -m sphinx -b markdown
CCUTILS := $(ACTIVATE) && $(PYTHON) -m ccutils.ccutils

# Jekyll commands
JEKYLL_BUILD := bundle exec jekyll build
JEKYLL_CLEAN := bundle exec jekyll clean
JEKYLL_SERVE := bundle exec jekyll serve

# -------------------------------------------------------------------
.PHONY: all venv install lint-check lint-fix typecheck test docs jekyll-serve clean help

# Default: run lint, typecheck, tests, and docs
all: lint-check typecheck test docs

# Virtual Environment Setup
venv:
	@echo "Creating virtual environment..."
	$(CREATE_VENV)
	@echo "✅ Virtual environment created."

# Install dev dependencies
install: venv
	@echo "📦 Installing project dependencies..."
	$(PIP) install --upgrade pip
	$(PIP) install -e $(DEV_DEPS)
	@echo "✅ Dependencies installed."

# Lint Check
lint-check: install
	$(RUFF) check $(SRC_DIR) $(TEST_DIR)

# Lint auto-fix
lint-fix: install
	$(RUFF) check --fix --show-files $(SRC_DIR) $(TEST_DIR)

# Type checking
typecheck: install
	$(MYPY) $(SRC_DIR)

# Run tests
test: install
	$(PYTEST) -v --maxfail=1 --disable-warnings $(TEST_DIR)

# Docs: build Sphinx Markdown and copy into Jekyll
docs: install
	@echo "📘 Building Sphinx documentation as Markdown..."
	$(SPHINX) $(SPHINX_DIR) $(JEKYLL_OUTPUT_DIR)
	@echo "✅ Sphinx Markdown build complete!"
	@echo "🧱 Building Jekyll site..."
	cd $(JEKYLL_DIR) && $(JEKYLL_BUILD)
	@echo "✅ Full documentation build complete!"

jekyll-serve: docs
	@echo "🚀 Starting Jekyll development server..."
	cd $(JEKYLL_DIR) && $(JEKYLL_SERVE)

run: install
	$(CCUTILS)

# Clean build artifacts
clean:
	rm -rf $(SPHINX_DIR)/_build $(JEKYLL_OUTPUT_DIR)
	cd $(JEKYLL_DIR) && $(JEKYLL_CLEAN)
	rm -rf build dist *.egg-info
	find $(SRC_DIR) $(TEST_DIR) -name "__pycache__" -type d -exec rm -rf {} +
	-[ -d "$(VENV_DIR)" ] && rm -r $(VENV_DIR)
	@echo "🧹 Cleaned build artifacts."

help:
	@echo "📦 ccutils Makefile"
	@echo ""
	@echo "Usage:"
	@echo "  make venv        Create virtual environment"
	@echo "  make install     Install dependencies"
	@echo "  make lint-check  Run Ruff linter"
	@echo "  make lint-fix    Auto-fix lint issues"
	@echo "  make typecheck   Run Mypy type checking"
	@echo "  make test        Run Pytest suite"
	@echo "  make docs        Build Sphinx + Jekyll documentation"
	@echo "  make run         Run ccutils.py"
	@echo "  make clean       Clean build artifacts"
	@echo "  make all         Run lint, typecheck, test, and docs"
