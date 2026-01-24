# Makefile
# =========================================
# Project: nutri-matic 🍹
# =========================================

# --------------------------------------------------
# ⚙️ Environment Settings
# --------------------------------------------------
SHELL := /bin/bash
.SHELLFLAGS := -O globstar -c

# If V is set to '1' or 'y' on the command line,
# AT will be empty (verbose).  Otherwise, AT will
# contain '@' (quiet by default).  The '?' is a
# conditional assignment operator: it only sets V
# if it hasn't been set externally.
V ?= 0
ifeq ($(V),0)
    AT = @
else
    AT =
endif
# Detect if we are running inside GitHub Actions CI.
# GitHub sets the environment variable GITHUB_ACTIONS=true in workflows.
# We set CI=1 if running in GitHub Actions, otherwise CI=0 for local runs.
ifeq ($(GITHUB_ACTIONS),true)
CI := 1
else
CI := 0
endif

# --------------------------------------------------
# 🏗️ CI/CD Functions
# --------------------------------------------------
# Returns true when CI is off and gracefully moves through failed checks.
define run_ci_safe =
( $1 || \
	if [ "$(CI)" != "1" ]; then \
		echo "❌ process finished with error; continuing..."; \
		true; \
	else \
		echo "❌ process finished with error"; \
		exit 1; \
	fi \
)
endef
# --------------------------------------------------
# ⚙️ Build Settings
# --------------------------------------------------
PACKAGE_NAME := "nutri-matic"
AUTHOR := "Jared Cook"
VERSION := "0.1.12"
RELEASE := v$(VERSION)
# --------------------------------------------------
# 🐙 Github Build Settings
# --------------------------------------------------
GITHUB_USER := "jcook3701"
GITHUB_REPO := $(GITHUB_USER)/$(PACKAGE_NAME)
# --------------------------------------------------
# 📁 Build Directories
# --------------------------------------------------
PROJECT_ROOT := $(PWD)
SRC_DIR := $(PROJECT_ROOT)/src
TESTS_DIR := $(PROJECT_ROOT)/tests
DOCS_DIR := $(PROJECT_ROOT)/docs
SPHINX_DIR := $(DOCS_DIR)/sphinx
JEKYLL_DIR := $(DOCS_DIR)/jekyll
JEKYLL_SPHINX_DIR := $(JEKYLL_DIR)/sphinx
README_GEN_DIR := $(JEKYLL_DIR)/tmp_readme
CHANGELOG_DIR := $(PROJECT_ROOT)/changelogs
CHANGELOG_RELEASE_DIR := $(CHANGELOG_DIR)/releases
# --------------------------------------------------
# 📄 Build Files
# --------------------------------------------------
README_FILE := $(PROJECT_ROOT)/README.md
CHANGELOG_FILE := $(CHANGELOG_DIR)/CHANGELOG.md
CHANGELOG_RELEASE_FILE := $(CHANGELOG_RELEASE_DIR)/$(RELEASE).md
# --------------------------------------------------
# 🐍 Python / Virtual Environment
# --------------------------------------------------
PYTHON_CMD := python3.11
VENV_DIR := $(PROJECT_ROOT)/.venv
# --------------------------------------------------
# 🐍 Python Dependencies
# --------------------------------------------------
DEPS := .
DEV_DEPS := .[dev]
DEV_DOCS := .[docs]
# --------------------------------------------------
# 🐍️ Python Commands (venv, activate, pip)
# --------------------------------------------------
CREATE_VENV := $(PYTHON_CMD) -m venv $(VENV_DIR)
ACTIVATE := source $(VENV_DIR)/bin/activate
PYTHON := $(ACTIVATE) && $(PYTHON_CMD)
PIP := $(PYTHON) -m pip
# --------------------------------------------------
# 🧬 Dependency Management (deptry)
# --------------------------------------------------
DEPTRY := $(ACTIVATE) && deptry
# --------------------------------------------------
# 🛡️ Security Audit (pip-audit)
# --------------------------------------------------
PIPAUDIT :=	$(ACTIVATE) && pip-audit
# --------------------------------------------------
# 🎨 Formatting (black)
# --------------------------------------------------
BLACK := $(PYTHON) -m black
# --------------------------------------------------
# 🔍 Linting (ruff, yaml)
# --------------------------------------------------
RUFF := $(PYTHON) -m ruff
TOMLLINT := tomllint
YAMLLINT := $(PYTHON) -m yamllint
# --------------------------------------------------
# 🎓 Spellchecker (codespell)
# --------------------------------------------------
CODESPELL := $(ACTIVATE) && codespell
# --------------------------------------------------
# 🧠 Typing (mypy)
# --------------------------------------------------
MYPY := $(PYTHON) -m mypy
# --------------------------------------------------
# 🧪 Testing (pytest)
# --------------------------------------------------
PYTEST := $(PYTHON) -m pytest
COVERAGE := $(ACTIVATE) && coverage run -m pytest
# --------------------------------------------------
# 📚 Documentation (Sphinx + Jekyll)
# --------------------------------------------------
SPHINX := $(PYTHON) -m sphinx -b markdown
JEKYLL_BUILD := bundle exec jekyll build --quiet
JEKYLL_CLEAN := bundle exec jekyll clean
JEKYLL_SERVE := bundle exec jekyll serve
# --------------------------------------------------
# 🔖 Version Bumping (bumpy-my-version)
# --------------------------------------------------
BUMPVERSION := $(ACTIVATE) && bump-my-version bump --verbose
# Patch types:
MAJOR := major
MINOR := minor
PATCH := patch
# --------------------------------------------------
# 📜 Changelog generation (git-clif)
# --------------------------------------------------
GITCLIFF := git cliff
GITCLIFF_CHANGELOG := $(GITCLIFF) --output $(CHANGELOG_FILE)
GITCLIFF_CHANGELOG_RELEASE := $(GITCLIFF) --unreleased --tag $(RELEASE) --output $(CHANGELOG_RELEASE_FILE)
# --------------------------------------------------
# 🐙 Github Tools (git)
# --------------------------------------------------
GIT := git
GITHUB := gh
# --------------------------------------------------
# 🚨 Pre-Commit (pre-commit)
# --------------------------------------------------
PRECOMMIT := $(ACTIVATE) && pre-commit
# --------------------------------------------------
# 📦 Build (build)
# --------------------------------------------------
BUILD := $(PYTHON) -m build
# --------------------------------------------------
# 🚀 Publishing (twine)
# --------------------------------------------------
TWINE := $(PYTHON) -m twine
# Repos:
PYPI := upload dist/*
TESTPYPI := upload --repository testpypi --verbose dist/*
# --------------------------------------------------
# 🏃‍♂️ nutrimatic command
# --------------------------------------------------
NUTRIMATIC := $(PYTHON) -m nutrimatic
# -------------------------------------------------------------------
.PHONY: all list-folders venv install black-formatter-check black-formatter-fix format-check format-fix \
	ruff-lint-check ruff-lint-fix yaml-lint-check lint-check lint-fix \
	typecheck test sphinx jekyll jekyll-serve build-docs run-docs readme \
	build publish clean help
# -------------------------------------------------------------------
# Default: run install, lint, typecheck, tests, and build-docs
# -------------------------------------------------------------------
all: clean install lint-check typecheck test build-docs readme
# --------------------------------------------------
# Make Internal Utilities
# --------------------------------------------------
list-folders:
	$(AT)printf "\
	🐍 src: $(SRC_DIR)\n\
	🧪 Test: $(TESTS_DIR)\n"
# --------------------------------------------------
# Dependency Checks
# --------------------------------------------------
git-check:
	$(AT)which $(GIT) >/dev/null || \
		{ echo "Git is required: sudo apt install git"; exit 1; }

gh-check:
	$(AT)which $(GITHUB) >/dev/null || \
		{ echo "GitHub is required: sudo apt install gh"; exit 1; }
# --------------------------------------------------
# 🐍 Virtual Environment Setup
# --------------------------------------------------
venv:
	$(AT)echo "🐍 Creating virtual environment..."
	$(AT)$(CREATE_VENV)
	$(AT)echo "✅ Virtual environment created."

install: venv
	$(AT)echo "📦 Installing project dependencies..."
	$(AT)$(PIP) install --upgrade pip setuptools wheel
	$(AT)$(PIP) install -e $(DEPS)
	$(AT)$(PIP) install -e $(DEV_DEPS)
	$(AT)$(PIP) install -e $(DEV_DOCS)
	$(AT)echo "✅ Dependencies installed."
# --------------------------------------------------
# 🚨 Pre-Commit (pre-commit)
# --------------------------------------------------
# NOTE: Should only be needed once!
pre-commit-init:
	$(AT)echo "📦 Installing pre-commit hooks and hook-types..."
	$(AT)which $(GIT) >/dev/null || { $(AT)echo "Git is required"; exit 1; }
	$(AT)$(PRECOMMIT) install --install-hooks
	$(AT)$(PRECOMMIT) install --hook-type pre-commit --hook-type commit-msg --hook-type typos-commit-msg
	$(AT)echo "✅ pre-commit dependencies installed!"
# --------------------------------------------------
# 🛡️ Security (pip-audit)
# --------------------------------------------------
security:
	$(AT)echo "🛡️ Running security audit..."
	$(AT)$(call run_ci_safe, $(PIPAUDIT))
	$(AT)echo "✅ Finished security audit!"
# --------------------------------------------------
# 🧬 Dependency Management (deptry)
# --------------------------------------------------
dependency-check:
	$(AT)echo "🧬 Checking dependency issues..."
	$(AT)$(DEPTRY) --pep621-dev-dependency-groups dev,docs \
		 $(SRC_DIR)
	$(AT)echo "✅ Finished checking for dependency issues!"
# --------------------------------------------------
# 🎨 Formatting (black)
# --------------------------------------------------
black-formatter-check:
	$(AT)echo "🔍 Running black formatter style check..."
	$(AT)$(call run_ci_safe, $(BLACK) --check $(SRC_DIR) $(TESTS_DIR))
	$(AT)echo "✅ Finished formatting check of Python code with Black!"

black-formatter-fix:
	$(AT)echo "🎨 Running black formatter fixes..."
	$(AT)$(BLACK) $(SRC_DIR) $(TESTS_DIR)
	$(AT)echo "✅ Finished formatting Python code with Black!"

format-check: black-formatter-check
format-fix: black-formatter-fix
# --------------------------------------------------
# 🔍 Linting (ruff, yaml)
# --------------------------------------------------
ruff-lint-check:
	$(AT)echo "🔍 Running ruff linting..."
	$(AT)$(MAKE) list-folders
	$(AT)$(call run_ci_safe, $(RUFF) check $(SRC_DIR) $(TESTS_DIR))
	$(AT)echo "✅ Python lint check complete!"

ruff-lint-fix:
	$(AT)echo "🎨 Running ruff lint fixes..."
	$(AT)$(RUFF) check --show-files $(SRC_DIR) $(TESTS_DIR)
	$(AT)$(RUFF) check --fix $(SRC_DIR) $(TESTS_DIR)
	$(AT)echo "✅ Python lint fix complete!"

toml-lint-check:
	$(AT)echo "🔍 Running Tomllint..."
	$(AT)$(ACTIVATE) && \
		find $(PROJECT_ROOT) -name "*.toml" \
			! -path "$(VENV_DIR)/*" \
			! -path "*{{*" \
			! -path "*}}*" \
			-print0 | xargs -0 -n 1 $(TOMLLINT)
	$(AT)echo "✅ Finished linting check of toml configuration files with Tomllint!"

yaml-lint-check:
	$(AT)echo "🔍 Running yamllint..."
	$(AT)$(YAMLLINT) .
	$(AT)echo "✅ Yaml lint check complete!"

lint-check: ruff-lint-check toml-lint-check yaml-lint-check
lint-fix: ruff-lint-fix
# --------------------------------------------------
# 🎓 Spellchecker (codespell)
# --------------------------------------------------
spellcheck:
	$(AT)echo "🎓 Checking Spelling (codespell)..."
	$(AT)$(CODESPELL)
	$(AT)echo "✅ Finished spellcheck!"
# --------------------------------------------------
# 🧠 Typechecking (MyPy)
# --------------------------------------------------
typecheck:
	$(AT)echo "🧠 Checking types (MyPy)..."
	$(AT)$(call run_ci_safe, $(MYPY) $(SRC_DIR) $(TESTS_DIR))
	$(AT)echo "✅ Python typecheck complete!"
# --------------------------------------------------
# 🧪 Testing (pytest)
# --------------------------------------------------
test:
	$(AT)echo "🧪 Running tests with pytest..."
	$(AT)$(call run_ci_safe, $(PYTEST) $(TESTS_DIR))
	$(AT)echo "✅ Python tests complete!"
# --------------------------------------------------
# 📚 Documentation (Sphinx + Jekyll + nutrimatic)
# --------------------------------------------------
sphinx:
	$(ACTIVATE) && $(MAKE) -C $(SPHINX_DIR) all PUBLISHDIR=$(JEKYLL_SPHINX_DIR)

jekyll:
	$(MAKE) -C $(JEKYLL_DIR) build;

jekyll-serve:
	$(MAKE) -C $(JEKYLL_DIR) run;

readme:
	$(AT)$(NUTRIMATIC) build readme $(JEKYLL_DIR) $(README_FILE) \
		--tmp-dir $(README_GEN_DIR) --jekyll-cmd '$(JEKYLL_BUILD)'

# Note: Run as part of pre-commit.  No manual run needed.
build-docs: sphinx jekyll readme
	$(AT)$(GIT) add $(DOCS_DIR)
	$(AT)$(GIT) add $(README_FILE)

run-docs: jekyll-serve
# --------------------------------------------------
# 🔖 Version Bumping (bumpy-my-version)
# --------------------------------------------------
# TODO: Also create a git tag of current version.
bump-version-patch:
	$(AT)echo "🔖 Updating $(PACKAGE_NAME) version from $(VERSION)..."
	$(AT)$(BUMPVERSION) $(PATCH)
	$(AT)echo "✅ $(PACKAGE_NAME) version update complete!"
# --------------------------------------------------
# 📜 Changelog generation (git-cliff) # TODO: Convert this to ansible-changelog
# --------------------------------------------------
# Note: Run as part of pre-commit.  No manual run needed.
changelog:
	$(AT)echo "📜 $(PACKAGE_NAME) Changelog Generation..."
	$(AT)$(GITCLIFF_CHANGELOG)
	$(AT)$(GITCLIFF_CHANGELOG_RELEASE)
	$(AT)$(GIT) add $(CHANGELOG_FILE)
	$(AT)$(GIT) add $(CHANGELOG_RELEASE_FILE)
	$(AT)echo "✅ Finished Changelog Update!"

changelog-test:
	$(AT)echo $(GITCLIFF_CHANGELOG)
	$(AT)echo $(GITCLIFF_CHANGELOG_RELEASE)
# --------------------------------------------------
# 📦 Build program (build)
# --------------------------------------------------
build:
	$(AT)echo "📦 Packing $(PACKAGE_NAME)..."
	$(AT)$(BUILD)
	$(AT)echo "✅ $(PACKAGE_NAME) packaging complete!"
# --------------------------------------------------
# 🐙 Github Commands (git)
# --------------------------------------------------
#NOTE: Not yet tested!!!
git-release:
	$(AT)echo "📦 $(PACKAGE_NAME) Release Tag - $(RELEASE)! 🎉"
	$(AT)$(GIT) tag -a $(RELEASE) -m "Release $(RELEASE)"
	$(AT)$(GIT) push origin $(RELEASE)
	$(AT)$(GITHUB) release create $(RELEASE) --generate-notes
	$(AT)echo "✅ Finished uploading Release - $(RELEASE)! 🎉"
# --------------------------------------------------
# 🚀 Publish program (twine) (Repos: Testpypi, & Pypi)
# --------------------------------------------------
publish-test:
	$(AT)echo "🚀 Publishing $(PACKAGE_NAME) to testpypi..."
	$(AT)$(TWINE) $(TESTPYPI)
	$(AT)echo "✅ $(PACKAGE_NAME) upload complete!"

publish:
	$(AT)echo "🚀 Publishing $(PACKAGE_NAME) to pypi..."
	$(AT)$(TWINE) $(PYPI)
	$(AT)echo "✅ $(PACKAGE_NAME) upload complete!"
# --------------------------------------------------
# 📢 Release
# --------------------------------------------------
pre-commit: test security dependency-check format-fix lint-check spellcheck typecheck
pre-release: clean install pre-commit build-docs changelog build
test-release: pre-release publish-test
## TODO: Add test to make sure that we are not about to publish an already released version
## TODO: Need to add a git add --all && git commit -m "automessage" between git-release
##       and bump-version-patch otherwise always errors out.
## example: git commit -m "chore(changelogs): changelog updates."
## TODO: After version bump:
##       git add --all
##       git commit -m "chore(version): Version Bump."
## TODO: jinja ci/cd broken still.
release: pre-release publish git-release bump-version-patch
# --------------------------------------------------
# 🧹 Clean artifacts
# --------------------------------------------------
clean-docs:
	$(AT)echo "🧹 Cleaning documentation artifacts..."
	$(AT)$(MAKE) -C $(JEKYLL_DIR) clean
	$(AT)$(MAKE) -C $(SPHINX_DIR) clean
	$(AT)echo "✅ Cleaned documentation artifacts..."

clean-build:
	$(AT)echo "🧹 Cleaning build artifacts..."
	$(AT)rm -rf build dist *.egg-info
	$(AT)find $(SRC_DIR) $(TESTS_DIR) -name "__pycache__" -type d -exec rm -rf {} +
	$(AT)rm -rf $(VENV_DIR)
	$(AT)echo "✅ Finished cleaning build artifacts..."

clean: clean-docs clean-build
# --------------------------------------------------
# Version
# --------------------------------------------------
version:
	$(AT)echo "$(PACKAGE_NAME)"
	$(AT)echo "author: $(AUTHOR)"
	$(AT)echo "version: $(VERSION)"
# --------------------------------------------------
# ❓ Help
# --------------------------------------------------
help:
	$(AT)echo "📦 $(PACKAGE_NAME) Makefile"
	$(AT)echo ""
	$(AT)echo "Usage:"
	$(AT)echo "  make venv                   Create virtual environment"
	$(AT)echo "  make install                Install dependencies"
	$(AT)echo "  make format-check           Run all project formatter checks (black)"
	$(AT)echo "  make format-fix             Run all project formatter autofixes (black)"
	$(AT)echo "  make ruff-lint-check        Run Ruff linter"
	$(AT)echo "  make ruff-lint-fix          Auto-fix lint issues with python ruff"
	$(AT)echo "  make yaml-lint-check        Run YAML linter"
	$(AT)echo "  make lint-check             Run all project linters (ruff, & yaml)"
	$(AT)echo "  make lint-fix               Run all project linter autofixes (ruff)"
	$(AT)echo "  make typecheck              Run Mypy type checking"
	$(AT)echo "  make test                   Run Pytest suite"
	$(AT)echo "  make build-docs             Build Sphinx + Jekyll documentation"
	$(AT)echo "  make run-docs               Preview Jekyll documentation"
	$(AT)echo "  make readme                 Uses Jekyll $(JEKYLL_DIR)/README.md for readme generation"
	$(AT)echo "  make clean                  Clean build artifacts"
	$(AT)echo "  make all                    Run lint, typecheck, test, and docs"
	$(AT)echo "Options:"
	$(AT)echo "  V=1             Enable verbose output (show all commands being executed)"
	$(AT)echo "  make -s         Run completely silently (suppress make's own output AND command echo)"
