"""nutri-matic Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
"""

import shutil
from pathlib import Path
from typing import Any

from cookiecutter.main import cookiecutter

from nutrimatic.core.config import ensure_config
from nutrimatic.core.logger import setup_logging

cfg = ensure_config()  # loads singleton config
logger = setup_logging(cfg)  # loads singleton logger


def generate_docs_templates(context: dict[str, Any]) -> None:
    """Generate one or more documentation templates inside docs/"""
    if context.get("_is_sub_template"):
        logger.debug("Skipping docs generation inside sub-template")
        return

    project_dir = Path.cwd()
    docs_dir = project_dir / "docs"
    tmp_dir = docs_dir / "_tmp_docs"

    tmp_dir.mkdir(parents=True, exist_ok=True)

    project_name = context.get("package_name") or context.get("project_name")

    base_ctx = {
        "project_name": project_name,
        "project_slug": context.get("project_slug"),
        "company": context.get("company"),
        "author": context.get("author"),
        "email": context.get("email"),
        "version": context.get("version"),
        "timezone": context.get("timezone"),
        "license": context.get("license"),
        "contribution_model": context.get("contribution_model"),
        "publication_year": context.get("publication_year"),
        "current_year": context.get("current_year"),
        "__year_range": context.get("__year_range"),
        "copyright": context.get("copyright"),
        "description": context.get("description"),
        "github_org": context.get("github_org"),
        "template_type": context.get("template_type"),
        "_is_sub_template": True,
    }

    templates = {
        "github": {
            "enabled": context.get("add_github_docs", True),
            "name": "Github",
            "repo": "jcook3701/github-docs-cookiecutter",
            "target": docs_dir / "jekyll",
            "extra_ctx": {
                **base_ctx,
                "theme": context.get("theme"),
                "ga_tracking": context.get("ga_tracking"),
                "github_username": context.get("github_username"),
                "linkedin_usercode": context.get("linkedin_usercode"),
                "twitter_username": context.get("twitter_username"),
                "buymeacoffee_username": context.get("buymeacoffee_username"),
                "repo_url": context.get("repo_url"),
            },
        },
        "sphinx": {
            "enabled": context.get("add_sphinx_docs", True),
            "name": "Sphinx",
            "repo": "jcook3701/sphinx-cookiecutter",
            "target": docs_dir / "sphinx",
            "extra_ctx": {
                **base_ctx,
            },
        },
    }

    for _key, cfg in templates.items():
        if not cfg.get("enabled", True):
            logger.info(f"🚫 Skipping {cfg['name']} docs (disabled)")
            continue

        name = cfg["name"]
        repo = cfg["repo"]
        target = cfg["target"]
        extra_ctx = cfg["extra_ctx"]

        logger.info(f"📦 Generating {name} docs from {repo} → {target}")
        try:
            if target.exists() and any(target.iterdir()):
                logger.info(f"⏭️ Skipping {name}: {target} already exists.")
                continue

            # Bake template into temp directory
            cookiecutter(
                f"https://github.com/{repo}.git",
                no_input=True,
                extra_context=extra_ctx,
                output_dir=tmp_dir,
            )

            # Find the generated folder (Cookiecutter creates a subfolder automatically)
            subdirs = [d for d in tmp_dir.iterdir() if d.is_dir()]
            if not subdirs:
                logger.info(f"⚠️  No generated directory found for {name}")
                continue

            generated_dir = subdirs[0]

            shutil.move(generated_dir, target)

            # Clean up tmp
            for d in tmp_dir.iterdir():
                if d.is_dir():
                    shutil.rmtree(d)

            logger.info(f"✅ {name} Docs generated in {target}")

        except Exception as e:
            logger.info(f"⚠️  Skipping {name} Docs generation: {e}")

        logger.info("🎉 All documentation templates generated successfully!")
