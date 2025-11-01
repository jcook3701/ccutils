"""ccutils Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
Description: Tests for ccutils.run
"""

import json
from pathlib import Path
from unittest.mock import patch

from ccutils.run import run_template


def test_run_template_calls_cookiecutter(tmp_path: Path) -> None:
    template_repo: str = "fake-repo"
    config_path: Path = tmp_path / "config.json"
    config_data: dict[str, str] = {"project_name": "MyProject"}
    config_path.write_text(json.dumps(config_data))

    with patch("ccutils.run.cookiecutter") as mock_cc:
        run_template(template_repo, str(config_path))
        mock_cc.assert_called_once()
        _, kwargs = mock_cc.call_args
        assert kwargs["extra_context"] == config_data
        assert kwargs["no_input"] is True
