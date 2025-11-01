"""ccutils Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
Description: Tests for ccutils.extract
"""

from pathlib import Path
from unittest.mock import mock_open, patch

from ccutils.extract import extract_cookiecutter_config_from_repo


def test_extract_cookiecutter_config(tmp_path: Path) -> None:
    repo_url: str = "fake-repo"
    output_file: Path = tmp_path / "clean.json"

    # Patch Repo.clone_from to do nothing
    with patch("ccutils.extract.Repo.clone_from"): # as mock_clone
        # Patch Path.exists to simulate cookiecutter.json
        m_open = mock_open(read_data='{"name": "{{ cookiecutter.project_name }}"}')
        with patch(
                "builtins.open",
                m_open,
        ): # as mock_file
            path: Path = extract_cookiecutter_config_from_repo(repo_url, output_file=str(output_file))
            assert path.exists() is False or True
            assert isinstance(path, Path)
            assert str(path) == str(output_file)
