---
title: nutrimatic.models.template
layout: default
nav_order: 2
parent: api
---
nutrimatic.models.template
==========================

<a id="module-nutrimatic.models.template"></a>

nutri-matic Package

Description: Template Models:
(TemplateRepo, Namespace, ConfigData)

### Classes

| [`ConfigData`](#nutrimatic.models.template.ConfigData)(\*\*data)     | Metadata from a cookiecutter template project's config.json   |
|----------------------------------------------------------------------|---------------------------------------------------------------|
| [`Namespace`](#nutrimatic.models.template.Namespace)(\*\*data)       | A GitHub user/org containing templates                        |
| [`TemplateRepo`](#nutrimatic.models.template.TemplateRepo)(\*\*data) | A cookiecutter template repo                                  |

### *class* nutrimatic.models.template.ConfigData(\*\*data)

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

### *class* nutrimatic.models.template.TemplateRepo(\*\*data)

Bases: `BaseModel`

A cookiecutter template repo

#### repo

(GitHubRepo) GitHub repository information.

#### config

(ConfigData) Metadata from a cookiecutter template.

#### repo *: [GitHubRepo](nutrimatic.models.github.md#nutrimatic.models.github.GitHubRepo)*

#### config *: [ConfigData](#nutrimatic.models.template.ConfigData) | None*

### *class* nutrimatic.models.template.Namespace(\*\*data)

Bases: `BaseModel`

A GitHub user/org containing templates

#### templates

(list[TemplateRepo]) List of GitHub namespace/organization template repositories.

#### templates *: list[[TemplateRepo](#nutrimatic.models.template.TemplateRepo)]*

#### created_at *: datetime*
