# Makefile
# =========================================
# Project: ccutils
# =========================================

# --------------------------------------------------
# ⚙️ Environment Settings
# --------------------------------------------------
SHELL := /bin/bash
.SHELLFLAGS := -O globstar -c
# --------------------------------------------------
# 📁 Build Directories
# --------------------------------------------------
SRC_DIR := src
TEST_DIR := tests
SPHINX_DIR = docs/sphinx
JEKYLL_DIR = docs/jekyll

SPHINX_BUILD_DIR = $(SPHINX_DIR)/_build/html
JEKYLL_OUTPUT_DIR = $(JEKYLL_DIR)/sphinx
# --------------------------------------------------
# Python 🐍 / Virtual Environment
# --------------------------------------------------
PYTHON := python3.11
VENV_DIR := .venv
# --------------------------------------------------
# Python 🐍 Dependencies
# --------------------------------------------------
DEPS := .
DEV_DEPS := .[dev]
DEV_DOCS := .[docs]
# --------------------------------------------------
# ⚙️ Python Commands (venv, activate, pip)
# --------------------------------------------------
CREATE_VENV := $(PYTHON) -m venv $(VENV_DIR)
ACTIVATE = source $(VENV_DIR)/bin/activate
PIP := $(ACTIVATE) && $(PYTHON) -m pip
# --------------------------------------------------
# 🧠 Typing (mypy)
# --------------------------------------------------
MYPY := $(ACTIVATE) && $(PYTHON) -m mypy
# --------------------------------------------------
# 🔍 Linting (ruff, yaml)
# --------------------------------------------------
RUFF := $(ACTIVATE) && $(PYTHON) -m ruff
YAMLLINT := $(ACTIVATE) && $(PYTHON) -m yamllint
# --------------------------------------------------
# 🧪 Testing (pytest)
# --------------------------------------------------
PYTEST := $(ACTIVATE) && $(PYTHON) -m pytest
# --------------------------------------------------
# 📘 Documentation (Sphinx + Jekyll)
# --------------------------------------------------
SPHINX := $(ACTIVATE) && $(PYTHON) -m sphinx -b markdown
JEKYLL_BUILD := bundle exec jekyll build
JEKYLL_CLEAN := bundle exec jekyll clean
JEKYLL_SERVE := bundle exec jekyll serve
# --------------------------------------------------
# ccutils command
# --------------------------------------------------
CCUTILS := $(ACTIVATE) && $(PYTHON) -m ccutils.ccutils

# -------------------------------------------------------------------
.PHONY: all venv install ruff-lint-check ruff-lint-fix yaml-lint-check \
	lint-check typecheck test docs jekyll-serve clean help
# -------------------------------------------------------------------
# Default: run install, lint, typecheck, tests, and docs
# -------------------------------------------------------------------
all: install lint-check typecheck test docs

# --------------------------------------------------
# Virtual Environment Setup
# --------------------------------------------------
venv:
	@echo "🔨️ Creating virtual environment..."
	$(CREATE_VENV)
	@echo "✅ Virtual environment created."

install: venv
	@echo "📦 Installing project dependencies..."
	$(PIP) install --upgrade pip
	$(PIP) install -e $(DEPS)
	$(PIP) install -e $(DEV_DEPS)
	$(PIP) install -e $(DEV_DOCS)
	@echo "✅ Dependencies installed."

# --------------------------------------------------
# Linting (ruff, yaml, jinja2)
# --------------------------------------------------
ruff-lint-check:
	@echo "🔍 Running ruff linting..."
	$(RUFF) check $(SRC_DIR) $(TEST_DIR)

ruff-lint-fix:
	@echo "🎨 Running ruff lint fixes..."
	$(RUFF) check --show-files $(SRC_DIR) $(TEST_DIR)
	$(RUFF) check --fix $(SRC_DIR) $(TEST_DIR)

yaml-lint-check:
	@echo "🔍 Running yamllint..."
	$(YAMLLINT) .

lint-check: ruff-lint-check yaml-lint-check

# --------------------------------------------------
# Typechecking (MyPy)
# --------------------------------------------------
typecheck:
	@echo "🧠 Checking types (MyPy)..."
	$(MYPY) $(SRC_DIR) $(TEST_DIR)

# --------------------------------------------------
# Testing (pytest)
# --------------------------------------------------
test:
	@echo "🧪 Running tests with pytest..."
	$(PYTEST) -v --maxfail=1 --disable-warnings $(TEST_DIR)

# --------------------------------------------------
# Documentation (Sphinx + Jekyll)
# --------------------------------------------------
docs:
	@echo "🔨 Building Sphinx documentation 📘 as Markdown..."
	$(SPHINX) $(SPHINX_DIR) $(JEKYLL_OUTPUT_DIR)
	@echo "✅ Sphinx Markdown build complete!"
	@echo "🔨 Building Jekyll site..."
	cd $(JEKYLL_DIR) && $(JEKYLL_BUILD)
	@echo "✅ Full documentation build complete!"

jekyll-serve: docs
	@echo "🚀 Starting Jekyll development server..."
	cd $(JEKYLL_DIR) && $(JEKYLL_SERVE)

# --------------------------------------------------
# Run ccutils program
# --------------------------------------------------
run:
	@echo "🏃‍♂️ running ccurtils..."
	$(CCUTILS)

# --------------------------------------------------
# Clean artifacts
# --------------------------------------------------
clean:
	@echo "🧹 Clening build artifacts..."
	rm -rf $(SPHINX_DIR)/_build $(JEKYLL_OUTPUT_DIR)
	cd $(JEKYLL_DIR) && $(JEKYLL_CLEAN)
	rm -rf build dist *.egg-info
	find $(SRC_DIR) $(TEST_DIR) -name "__pycache__" -type d -exec rm -rf {} +
	-[ -d "$(VENV_DIR)" ] && rm -r $(VENV_DIR)
	@echo "🧹 Finished cleaning build artifacts..."

# --------------------------------------------------
# Help
# --------------------------------------------------
help:
	@echo "📦 ccutils Makefile"
	@echo ""
	@echo "Usage:"
	@echo "  make venv                   Create virtual environment"
	@echo "  make install                Install dependencies"
	@echo "  make ruff-lint-check        Run Ruff linter"
	@echo "  make ruff-lint-fix          Auto-fix lint issues with python ruff"
	@echo "  make yaml-lint-check        Run YAML linter"
	@echo "  make lint-check             Run all project linters (ruff, & yaml)"
	@echo "  make typecheck              Run Mypy type checking"
	@echo "  make test                   Run Pytest suite"
	@echo "  make docs                   Build Sphinx + Jekyll documentation"
	@echo "  make run                    Run ccutils.py"
	@echo "  make clean                  Clean build artifacts"
	@echo "  make all                    Run lint, typecheck, test, and docs"
