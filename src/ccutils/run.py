"""ccutils Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
Description: handles running a cookiecutter template with a given JSON

This module provides functions to:
  - Render a Cookiecutter template from a repository.
  - Use a JSON configuration file to supply template context.
  - Optionally specify a branch and output directory for the rendered project.
"""

import json

from cookiecutter.main import cookiecutter


def run_template(
        template_repo: str,
        config_path: str,
        checkout: str | None = None,
        output_dir: str = "."
) -> None:
    """Run a cookiecutter template with a pre-supplied JSON config."""
    with open(config_path) as f:
        extra_context: dict[str, object] = json.load(f)

    cookiecutter(
        template_repo,
        checkout=checkout,
        no_input=True,
        extra_context=extra_context,
        output_dir=output_dir,
    )

    print(f"Template {template_repo} rendered successfully in {output_dir}")
