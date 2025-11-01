"""ccutils Package

© All rights reserved. Jared Cook

See the LICENSE file for more details.

Author: Jared Cook
Description:
"""

import os
import shutil
import tempfile

from cookiecutter.main import cookiecutter


def add_docs(
        template_repo: str,
        target_dir: str,
        checkout: str = 'main',
        force: bool = False
) -> None:
    # Create a temp dir to render template
    with tempfile.TemporaryDirectory() as tmpdir:
        cookiecutter(
            template_repo,
            checkout=checkout,
            no_input=True,
            output_dir=tmpdir
        )

        # The rendered folder will be inside tmpdir
        rendered_path: str = next(
            os.path.join(tmpdir, d)
            for d in os.listdir(tmpdir)
            if os.path.isdir(os.path.join(tmpdir, d))
        )

        # Copy files over
        for root, _dirs, files in os.walk(rendered_path):
            rel_path: str = os.path.relpath(root, rendered_path)
            dest_root: str = os.path.join(target_dir, rel_path)

            os.makedirs(dest_root, exist_ok=True)

            for f in files:
                src: str = os.path.join(root, f)
                dest: str = os.path.join(dest_root, f)
                if not os.path.exists(dest) or force:
                    shutil.copy2(src, dest)
                    print(f"Added: {dest}")
                else:
                    print(f"Skipped: {dest} (exists)")

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description="Add GitHub docs to an existing project")
    parser.add_argument("target", help="Path to target project")
    parser.add_argument("--template", default="git@github.com:jcook3701/github-docs-cookiecutter.git")
    parser.add_argument("--branch", default="main")
    parser.add_argument("--force", action="store_true", help="Overwrite existing files")
    args = parser.parse_args()

    add_docs(args.template, args.target, args.branch, args.force)
