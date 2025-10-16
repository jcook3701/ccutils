# coding: utf-8
"""ccutils Package

© All rights reserved. Jared Cook

See the LICENSE.TXT file for more details.

Author: Jared Cook
Description: 
"""

import json
from cookiecutter.main import cookiecutter

def run_template(template_repo, config_path, checkout=None, output_dir="."):
    """Run a cookiecutter template with a pre-supplied JSON config."""
    with open(config_path, "r") as f:
        extra_context = json.load(f)

    cookiecutter(
        template_repo,
        checkout=checkout,
        no_input=True,
        extra_context=extra_context,
        output_dir=output_dir,
    )

    print(f"Template {template_repo} rendered successfully in {output_dir}")
