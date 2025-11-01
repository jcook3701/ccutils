"""ccutils Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
Description: Command-line interface for CCUtils: Cookiecutter automation utilities.

Provides commands to:
  - extract: Clone a Cookiecutter template repo, clean
    its cookiecutter.json of Jinja placeholders, and save locally.
  - run: Render a Cookiecutter template using a pre-supplied JSON config file.
"""

import json
import os
import re
import shutil
import tempfile
from pathlib import Path

import typer
from cookiecutter.main import cookiecutter
from git import Repo

app = typer.Typer(help="CCUtils: Cookiecutter automation utilities")

# -----------------------------
# Docs command
# -----------------------------
@app.command()
def add_docs(
    target_dir: str = typer.Argument(..., help="Path to existing project"),
    template_repo: str = typer.Option("git@github.com:jcook3701/github-docs-cookiecutter.git", help="GitHub docs template repo"),
    branch: str = typer.Option("main", help="Branch of the template repo"),
    force: bool = typer.Option(False, help="Overwrite existing files if they exist")
) -> None:
    """
    Add GitHub docs to an existing project using the github-docs-cookiecutter template.
    """

    with tempfile.TemporaryDirectory() as tmpdir:
        typer.echo(f"Cloning {template_repo} into {tmpdir} ...")
        Repo.clone_from(template_repo, tmpdir, branch=branch, depth=1)

        # Find the rendered template folder (the first directory in tmpdir)
        rendered_path = Path(tmpdir)

        for root, _dirs, files in os.walk(rendered_path):
            rel_path = Path(root).relative_to(rendered_path)
            dest_root = Path(target_dir) / rel_path

            dest_root.mkdir(parents=True, exist_ok=True)

            for f in files:
                src = Path(root) / f
                dest = dest_root / f
                if not dest.exists() or force:
                    shutil.copy2(src, dest)
                    typer.echo(f"Added: {dest}")
                else:
                    typer.echo(f"Skipped: {dest} (exists)")

# -----------------------------
# Extract command
# -----------------------------
@app.command()
def extract(
    repo: str = typer.Argument(..., help="GitHub repo URL of the cookiecutter template"),
    branch: str = typer.Option("main", help="Branch to use"),
    output: str = typer.Option("clean_cookiecutter.json", help="Output JSON file path")
) -> None:
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
) -> None:
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
