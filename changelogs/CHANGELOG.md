# --------------------------------------------------
# Changelog:
# --------------------------------------------------

## [unreleased]

### ⚙️  Miscellaneous

- *(version)* Version bump to 0.1.12!

### 🐛 Fixed

- *(docs)* Pass cookiecutter.project_slug between main generation project and documentation templates.
## [0.1.11] - 2026-01-06

### ⚙️  Miscellaneous

- *(version)* Version bump to 0.1.10!
- *(version)* Bump version to 0.1.11!
- Merge pull request #21 from jcook3701/feat-009

Feat 009
- Merge pull request #22 from jcook3701/develop

Develop
- *(changelogs)* Changelog update.

### 🐛 Fixed

- *(hooks)* Finally got cookiecutter sub-template recursion fixed!
## [0.1.10] - 2025-12-27

### ⚙️  Miscellaneous

- Feat 008 (#19)

* chore(changelog): changelog update!

* fix(hooks): documentation generation fix.
- Merge pull request #20 from jcook3701/develop

Feat 008 (#19)
- *(changelog)* Update changelog.
- *(version)* Bump version to 0.1.10!
## [0.1.9] - 2025-12-27

### ⚙️  Miscellaneous

- *(version)* Version bump to 1.8!
- Merge pull request #16 from jcook3701/feat-006

Feat 006
- Feat 007 (#17)

* chore(changelog): updates to changelog.

* chore(version): Version bump to 0.1.9!

* fix(hooks): docs hooks.
- Merge pull request #18 from jcook3701/develop

Feat 007 (#17)

### 🐛 Fixed

- *(hooks)* Fixed docs hooks for cookiecutter projects.
## [0.1.7] - 2025-12-23

### ⚙️  Miscellaneous

- Feat 003 (#9)

* feat(github): Got gh release create working.

* chore(bump): version bump.

* feat(cspell): setup pre-commit cspell.

* fix(minor): fixes for cookiecutter hooks. Timestamp autovars.

---------

Co-authored-by: jcook3701 <jcook3701@gmail.com>
- Merge pull request #10 from jcook3701/develop

Feat 003 (#9)
- Feat 004 (#11)

* fix(build): minor fix for makefile test-release

* chore(changelogs): changelog updates.

* chore(version): Version Bump.

* fix(github-pages): removed if statement from deploy that stopped manual runs from deploying.

* feat(hooks): added more hooks for template projects.

* fix(jekyll): Updates to ci/cd to make it so that jekyll deploys correctly on merge from dev to master.
- Merge pull request #12 from jcook3701/develop

Feat 004 (#11)
- Feat 005 (#14)

* chore(changelog): Updates to changelog for release.

* fix(build): forgot to add virtual environment source for bump-my-version command.

* chore(version): Version update to 1.6!

* feat(hooks): Added make.py to hooks so that different make commands can be chosen within the cookiecutter.json file rather than needing to template a ton for each variance of make commands that need to be run per-template.  I also refactored the make_dirs command out of hooks/utils and moved it to the core/utils directory.

* chore(changelog): updates changelogs.

* chore(version): bumped to version 0.1.7!

* fix(docs): Quick fix for documentation template generation.

* fix(lint): lint fix.
- Merge pull request #15 from jcook3701/develop

Feat 005 (#14)
## [0.1.3] - 2025-12-12

### ⚙️  Miscellaneous

- First commit
- Added updates for github pages
- Updates to github pages
- Updates to github pages
- Updates to github pages
- Makefile update and project file update.
- Updates to project files for ccutils.
- Develop (#1)

* updates

* linting, typechecked, and almost finished tests.

* all tests pass.  time to start manual tests.
- Develop (#2)

* updates

* linting, typechecked, and almost finished tests.

* all tests pass.  time to start manual tests.

* added readme generation to make project easier to manage and reduce copy and pasted file. ./README.md should only be modified with make readme

* Makefile cleanup.

* added sphinx documentation and more makefile updates.

* fixed removal of dependencies

* fixed makefile so clean wont remove sphinx docs again.

* Gemfile updates
- Develop (#3)

* updates

* linting, typechecked, and almost finished tests.

* all tests pass.  time to start manual tests.

* added readme generation to make project easier to manage and reduce copy and pasted file. ./README.md should only be modified with make readme

* Makefile cleanup.

* added sphinx documentation and more makefile updates.

* fixed removal of dependencies

* fixed makefile so clean wont remove sphinx docs again.

* Gemfile updates

* almost finished the list cookiecutter templates settup fixed.  Major project restructure and added models.

* all tests should pass.  Moved to full typer cmd line project.

* updates for logging and config file.

* Major project updates: Logging and Configuration are now working.  Looking like a real cli project.

* updates for metadata and configuration. Also added tools to makefile for build and publishing python package to pypi.

* Moved from ccutils project name to cc-utils to work with both pypi and testpypi.  Also added --version option that works with package metadata.

* add bump-my-version to project and setup to update version to make this easier to manage.

* makefile updates

* versioned the project to 0.1.1

* adding tools for cc-templates

* cc-util build readme works. Next to test add_yaml_front_matter

* updates to readme.

* updates to readme.

* updates to readme.

* updates to readme.

* readme and small makefile updates

* readme and small makefile updates

* readme updates

* updates to readme

* updates to readme

* Push before commit gets too large.

* Everything should pass

* update

---------

Co-authored-by: jcook3701 <jcook3701@gmail.com>
- Develop (#4)

* updates

* linting, typechecked, and almost finished tests.

* all tests pass.  time to start manual tests.

* added readme generation to make project easier to manage and reduce copy and pasted file. ./README.md should only be modified with make readme

* Makefile cleanup.

* added sphinx documentation and more makefile updates.

* fixed removal of dependencies

* fixed makefile so clean wont remove sphinx docs again.

* Gemfile updates

* almost finished the list cookiecutter templates settup fixed.  Major project restructure and added models.

* all tests should pass.  Moved to full typer cmd line project.

* updates for logging and config file.

* Major project updates: Logging and Configuration are now working.  Looking like a real cli project.

* updates for metadata and configuration. Also added tools to makefile for build and publishing python package to pypi.

* Moved from ccutils project name to cc-utils to work with both pypi and testpypi.  Also added --version option that works with package metadata.

* add bump-my-version to project and setup to update version to make this easier to manage.

* makefile updates

* versioned the project to 0.1.1

* adding tools for cc-templates

* cc-util build readme works. Next to test add_yaml_front_matter

* updates to readme.

* updates to readme.

* updates to readme.

* updates to readme.

* readme and small makefile updates

* readme and small makefile updates

* readme updates

* updates to readme

* updates to readme

* Push before commit gets too large.

* Everything should pass

* update

* moved project from cc-utils to nutri-matic

* rev project to 0.1.2

* updating docs.  just published current develop state to pypi.

* update to pre-gen-hooks

* feat(build): CI/CD updates and major updates to use pre-commit, codespell, deptry, & pip-audit. Also setup configuration for git-cliff chanagelog generation.

* fix(dependencies): Fixed errors from deptry.

* fix(docs): Updates to pre-commit to not remove double spaces from markdown files and fixed main readme file.

* fix(changelogs): Got changelogs setup how I actually want.  Now there should be a seperate changelog per a release as well as a running changelog.  Major updates to ci/cd as well.

* docs(readme): Updates for development cycle explanation.

* docs(readme): minor fixes

---------

Co-authored-by: jcook3701 <jcook3701@gmail.com>
- Feat 001 (#5)

* docs(jekyll): Fixed it so that sphinx api now shows correctly along with General FAQ's.

* docs(readme): Updates to include Package Installation with pip and information leading to github docs.

* fix(docs): Readme fix.

---------

Co-authored-by: jcook3701 <jcook3701@gmail.com>
- Merge pull request #6 from jcook3701/develop

Feat 001 (#5)
- *(bump)* Version bump.
- Merge pull request #7 from jcook3701/feat-002

Feat 002
- Merge pull request #8 from jcook3701/develop

Develop

### 🐛 Fixed

- *(ci/cd)* Fixed ci/cd so that it should now also run correct checks for feature branches.
- *(spelling)* Corrected spelling errors.
- *(linting)* Fixed error where nutrimatic/build was not being linted.
- *(readme)* Linting.
- *(readme)* Linting.

### 🚀 Added

- *(build)* Updates to yaml_front_matter so that it now works for both sphinx and autodoc applications.
