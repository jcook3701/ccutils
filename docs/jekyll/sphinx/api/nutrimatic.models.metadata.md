---
title: nutrimatic.models.metadata
layout: default
nav_order: 2
parent: api
---
nutrimatic.models.metadata
==========================

<a id="module-nutrimatic.models.metadata"></a>

nutri-matic Package

### Classes

| [`Metadata`](#nutrimatic.models.metadata.Metadata)(\*\*data)   | metadata type.   |
|----------------------------------------------------------------|------------------|

### *class* nutrimatic.models.metadata.Metadata(\*\*data)

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
  [`Metadata`](#nutrimatic.models.metadata.Metadata)
