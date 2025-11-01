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

import typer
from cookiecutter.main import cookiecutter
from git import Repo

app = typer.Typer(help="CCUtils: Cookiecutter automation utilities")

# -----------------------------
# Extract command
# -----------------------------
@app.command()
def extract(
    repo: str = typer.Argument(..., help="GitHub repo URL of the cookiecutter template"),
    branch: str = typer.Option("main", help="Branch to use"),
    output: str = typer.Option("clean_cookiecutter.json", help="Output JSON file path")
):
    """
    Clone a repo, extract cookiecutter.json, remove Jinja placeholders, save locally.
    """
    with tempfile.TemporaryDirectory() as tmpdir:
        typer.echo(f"Cloning {repo} into {tmpdir} ...")
        Repo.clone_from(repo, tmpdir, branch=branch, depth=1)

        config_path = Path(tmpdir) / "cookiecutter.json"
        if not config_path.exists():
            typer.echo(f"Error: No cookiecutter.json found in {repo}", err=True)
            raise typer.Exit(code=1)

        with open(config_path) as f:
            data = json.load(f)

        cleaned_data = {
            k: v for k, v in data.items()
            if not (isinstance(v, str) and re.search(r"{{\s*cookiecutter", v))
        }

        output_path = Path(output)
        with open(output_path, "w") as f:
            json.dump(cleaned_data, f, indent=4)

        typer.echo(f"Saved cleaned config to {output_path}")


# -----------------------------
# Run command
# -----------------------------
@app.command()
def run(
    template: str = typer.Argument(..., help="Cookiecutter template repo URL"),
    config: str = typer.Argument(..., help="Path to JSON config file"),
    branch: str = typer.Option(None, help="Branch to use in template repo"),
    output_dir: str = typer.Option(".", help="Directory to render template into")
):
    """
    Run a cookiecutter template using a pre-supplied JSON config.
    """
    with open(config) as f:
        extra_context = json.load(f)

    cookiecutter(
        template,
        checkout=branch,
        no_input=True,
        extra_context=extra_context,
        output_dir=output_dir
    )

    typer.echo(f"Template {template} rendered successfully in {output_dir}")


# -----------------------------
# Entry point
# -----------------------------
if __name__ == "__main__":
    app()
