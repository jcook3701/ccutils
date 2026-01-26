---
title: nutrimatic.models.github
layout: default
nav_order: 2
parent: api
---
nutrimatic.models.github
========================

<a id="module-nutrimatic.models.github"></a>

nutri-matic Package

Description: Github Models:
(GitHubaccount, RepoInfo)

### Classes

| [`GitHubAccount`](#nutrimatic.models.github.GitHubAccount)(\*\*data)   | GitHub users/org personal info                     |
|------------------------------------------------------------------------|----------------------------------------------------|
| [`GitHubAuth`](#nutrimatic.models.github.GitHubAuth)(\*\*data)         | GitHub authentication types.                       |
| [`GitHubRepo`](#nutrimatic.models.github.GitHubRepo)(\*\*data)         | Represents a GitHub repository within a namespace. |

### *class* nutrimatic.models.github.GitHubAuth(\*\*data)

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

### *class* nutrimatic.models.github.GitHubAccount(\*\*data)

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

#### auth *: [GitHubAuth](#nutrimatic.models.github.GitHubAuth)*

### *class* nutrimatic.models.github.GitHubRepo(\*\*data)

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
