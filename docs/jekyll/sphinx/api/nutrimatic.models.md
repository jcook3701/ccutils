---
title: nutrimatic.models
layout: default
nav_order: 2
parent: api
---
nutrimatic.models
=================

<a id="module-nutrimatic.models"></a>

nutri-matic Package

Description: Init python models (types)

### *class* nutrimatic.models.Accounts(\*\*data)

Bases: `BaseModel`

Represents user accounts.

#### github_username

GitHub username of the account.

* **Type:**
  str

#### twitter_username

Twitter handle.

* **Type:**
  str

#### linkedin_usercode

LinkedIn user code.

* **Type:**
  str

#### buymeacoffee_username

BuyMeACoffee username.

* **Type:**
  str

#### github_username *: str*

#### twitter_username *: str*

#### linkedin_usercode *: str*

#### buymeacoffee_username *: str*

### *class* nutrimatic.models.CCMeta(\*\*data)

Bases: `BaseModel`

Root model for teabag.toml.
Adjust fields as needed to match your teabag.toml structure.

#### template *: [CCTemplate](nutrimatic.models.cctemplate.md#nutrimatic.models.cctemplate.CCTemplate)*

#### tags *: list[str]*

#### features *: list[str]*

#### extra *: dict[str, object]*

#### *class* Config

Bases: `object`

#### extra *= 'allow'*

### *class* nutrimatic.models.CCTemplate(\*\*data)

Bases: `BaseModel`

A single template defined in ccmeta.toml.

#### name *: str*

#### description *: str | None*

#### path *: Path*

#### language *: str | None*

#### license *: str | None*

#### version *: str | None*

#### maintainer *: str | None*

#### project_type *: str | None*

#### variables *: list[[CCTemplateVariable](nutrimatic.models.cctemplate.md#nutrimatic.models.cctemplate.CCTemplateVariable)]*

#### tags *: list[str]*

#### features *: list[str]*

#### *class* Config

Bases: `object`

#### extra *= 'allow'*

### *class* nutrimatic.models.CCTemplateVariable(\*\*data)

Bases: `BaseModel`

Represents a single cookiecutter input variable.

#### name *: str*

#### default *: str | None*

#### description *: str | None*

### *class* nutrimatic.models.CLIConfig(\*\*data)

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

### *class* nutrimatic.models.ConfigData(\*\*data)

Bases: `BaseModel`

Metadata from a cookiecutter template project's config.json

#### project_name

Cookiecutter

#### author

Cookiecutter

#### version

Cookiecutter template version.

#### description

Cookiecutter project description.

#### variables

Cookiecutter project variables.

#### project_name *: str*

#### author *: str*

#### version *: str*

#### description *: str*

#### variables *: dict[str, Any]*

### *class* nutrimatic.models.GitHubAccount(\*\*data)

Bases: `BaseModel`

GitHub users/org personal info

#### user

(str) GitHub username.

#### namespace

(str) GitHub organization or namespace; often same as user.

#### email

(str) GitHub account email.

#### auth

(GitHubAuth) Authentication configuration for GitHub access.

#### user *: str*

#### namespace *: str*

#### email *: str*

#### auth *: [GitHubAuth](nutrimatic.models.github.md#nutrimatic.models.github.GitHubAuth)*

### *class* nutrimatic.models.GitHubAuth(\*\*data)

Bases: `BaseModel`

GitHub authentication types.

#### auth_type

Type of authentication method.

* **Type:**
  Literal['token', 'ssh']

#### token

GitHub personal access token, if using token authentication.

* **Type:**
  str | None

#### ssh_key_path

Path to SSH private key, if using SSH authentication.

* **Type:**
  Path | None

#### auth_type *: Literal['token', 'ssh']*

#### token *: str | None*

#### ssh_key_path *: Path | None*

### *class* nutrimatic.models.GitHubRepo(\*\*data)

Bases: `BaseModel`

Represents a GitHub repository within a namespace.

#### owner

(str) GitHub repository owner.

#### namespace

(str) GitHub organization or namespace; often same as user.

#### name

(str) GitHub repository name.

#### full_name

(str) GitHub owner fullname.

#### description

GitHub repository description.

#### url

(str) GitHub repository url.

#### html_url

(str).

#### ssh_url

(str).

#### clone_url

(str).

#### is_template

(bool).

#### owner *: str*

#### namespace *: str*

#### name *: str*

#### full_name *: str*

#### description *: str*

#### url *: str*

#### html_url *: str*

#### ssh_url *: str*

#### clone_url *: str*

#### is_template *: bool*

### *class* nutrimatic.models.Metadata(\*\*data)

Bases: `BaseModel`

metadata type.

#### version

(str).

#### author

(str).

#### license

(str).

#### copyright

(str).

#### version *: str*

#### author *: str*

#### license *: str*

#### *property* copyright *: str*

#### *classmethod* from_package(package_name='nutri-matic')

Create Metadata from the installed package metadata.

Falls back to defaults if the package is not found.

* **Return type:**
  [`Metadata`](nutrimatic.models.metadata.md#nutrimatic.models.metadata.Metadata)

### *class* nutrimatic.models.Namespace(\*\*data)

Bases: `BaseModel`

A GitHub user/org containing templates

#### templates

(list[TemplateRepo]) List of GitHub namespace/organization template repositories.

#### templates *: list[[TemplateRepo](nutrimatic.models.template.md#nutrimatic.models.template.TemplateRepo)]*

#### created_at *: datetime*

### *class* nutrimatic.models.TemplateRepo(\*\*data)

Bases: `BaseModel`

A cookiecutter template repo

#### repo

(GitHubRepo) GitHub repository information.

#### config

(ConfigData) Metadata from a cookiecutter template.

#### repo *: [GitHubRepo](nutrimatic.models.github.md#nutrimatic.models.github.GitHubRepo)*

#### config *: [ConfigData](nutrimatic.models.template.md#nutrimatic.models.template.ConfigData) | None*

### Modules

| [`accounts`](nutrimatic.models.accounts.md#module-nutrimatic.models.accounts)       | nutri-matic Package   |
|-------------------------------------------------------------------------------------|-----------------------|
| [`base`](nutrimatic.models.base.md#module-nutrimatic.models.base)                   | nutri-matic Package   |
| [`ccmeta`](nutrimatic.models.ccmeta.md#module-nutrimatic.models.ccmeta)             | nutri-matic Package   |
| [`cctemplate`](nutrimatic.models.cctemplate.md#module-nutrimatic.models.cctemplate) | nutri-matic Package   |
| [`config`](nutrimatic.models.config.md#module-nutrimatic.models.config)             | nutri-matic Package   |
| [`github`](nutrimatic.models.github.md#module-nutrimatic.models.github)             | nutri-matic Package   |
| [`metadata`](nutrimatic.models.metadata.md#module-nutrimatic.models.metadata)       | nutri-matic Package   |
| [`template`](nutrimatic.models.template.md#module-nutrimatic.models.template)       | nutri-matic Package   |
