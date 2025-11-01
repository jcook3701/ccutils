"""ccutils Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
Description:
"""

import json
import re
import tempfile
from pathlib import Path

from git import Repo  # Requires GitPython: pip install GitPython


def extract_cookiecutter_config_from_repo(repo_url, branch="main", output_file="clean_cookiecutter.json"):
    """
    Clone a repo, extract cookiecutter.json, remove Jinja placeholders, save locally.
    """
    with tempfile.TemporaryDirectory() as tmpdir:
        print(f"Cloning {repo_url} into {tmpdir} ...")
        Repo.clone_from(repo_url, tmpdir, branch=branch, depth=1)

        config_path = Path(tmpdir) / "cookiecutter.json"
        if not config_path.exists():
            raise FileNotFoundError(f"No cookiecutter.json found in {repo_url}")

        with open(config_path) as f:
            data = json.load(f)

        # Remove Jinja placeholders
        cleaned_data = {
            k: v for k, v in data.items()
            if not (isinstance(v, str) and re.search(r"{{\s*cookiecutter", v))
        }

        output_path = Path(output_file)
        with open(output_path, "w") as f:
            json.dump(cleaned_data, f, indent=4)

        print(f"Saved cleaned config to {output_path}")
        return output_path
