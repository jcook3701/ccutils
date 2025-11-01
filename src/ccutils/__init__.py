"""ccutils Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
Description: Cookiecutter utilities for automating project templates.
"""

__version__ = "0.1.0"
__author__ = "Jared Cook"
__license__ = "MIT"

from .cli import app
from .docs import add_docs
from .extract import extract_cookiecutter_config_from_repo
from .run import run_template

__all__ = ["app", "add_docs", "extract_cookiecutter_config_from_repo", "run_template"]
