"""ccutils Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
Description: Tests for ccutils.docs
"""

from pathlib import Path
from unittest.mock import patch

from ccutils.docs import add_docs


def test_add_docs_copies_files(tmp_path: Path) -> None:
    target_dir = tmp_path / "target"
    target_dir.mkdir()

    # Patch cookiecutter to just create a dummy folder with a file
    with patch("ccutils.docs.cookiecutter") as mock_cc:
        def fake_cookiecutter(
                template_repo: str,
                checkout: str,
                no_input: bool,
                output_dir: str
        ) -> None:
            # Create dummy rendered folder
            folder: Path = Path(output_dir) / "rendered_template"
            folder.mkdir()
            file: Path = folder / "README.md"
            file.write_text("Hello World")
        mock_cc.side_effect = fake_cookiecutter

        add_docs("fake-repo", str(target_dir))

        # Assert file copied
        copied_file: Path = target_dir /"README.md"
        assert copied_file.exists()
        assert copied_file.read_text() == "Hello World"
