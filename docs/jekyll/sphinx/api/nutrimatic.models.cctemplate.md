---
title: nutrimatic.models.cctemplate
layout: default
nav_order: 2
parent: api
---
nutrimatic.models.cctemplate
============================

<a id="module-nutrimatic.models.cctemplate"></a>

nutri-matic Package

### Classes

| [`CCTemplate`](#nutrimatic.models.cctemplate.CCTemplate)(\*\*data)                 | A single template defined in ccmeta.toml.        |
|------------------------------------------------------------------------------------|--------------------------------------------------|
| [`CCTemplateVariable`](#nutrimatic.models.cctemplate.CCTemplateVariable)(\*\*data) | Represents a single cookiecutter input variable. |

### *class* nutrimatic.models.cctemplate.CCTemplateVariable(\*\*data)

Bases: `BaseModel`

Represents a single cookiecutter input variable.

#### name *: str*

#### default *: str | None*

#### description *: str | None*

### *class* nutrimatic.models.cctemplate.CCTemplate(\*\*data)

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

#### variables *: list[[CCTemplateVariable](#nutrimatic.models.cctemplate.CCTemplateVariable)]*

#### tags *: list[str]*

#### features *: list[str]*

#### *class* Config

Bases: `object`

#### extra *= 'allow'*
