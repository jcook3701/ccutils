---
title: nutrimatic.models.config
layout: default
nav_order: 2
parent: api
---
nutrimatic.models.config
========================

<a id="module-nutrimatic.models.config"></a>

nutri-matic Package

Description: CLI Configuration model.

Configuration file location: ~/.config/nutri-matic/config.yml

### Classes

| [`CLIConfig`](#nutrimatic.models.config.CLIConfig)(\*\*data)   | Represents user CLI configuration nutri-matic.   |
|----------------------------------------------------------------|--------------------------------------------------|

### *class* nutrimatic.models.config.CLIConfig(\*\*data)

Bases: `BaseModel`

Represents user CLI configuration nutri-matic.

#### github

(GitHubAccount) GitHub users/org personal info.

#### ga_tracking

(str) Google Analytics Tracking number.

#### accounts

(Accounts) User accounts.

#### default_template_branch

(str)

#### cache_dir

(Path) Path to cache directory.

#### log_file

(Path) Path to log file.

#### verbose

(bool) Enable/Disable verbose mode.

#### github *: [GitHubAccount](nutrimatic.models.github.md#nutrimatic.models.github.GitHubAccount) | None*

#### ga_tracking *: str | None*

#### accounts *: [Accounts](nutrimatic.models.accounts.md#nutrimatic.models.accounts.Accounts) | None*

#### default_template_branch *: str*

#### cache_dir *: Path*

#### log_file *: Path*

#### verbose *: bool*

#### *property* log_dir *: Path*
