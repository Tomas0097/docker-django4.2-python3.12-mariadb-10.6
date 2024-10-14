#!/usr/bin/env sh

set -e

git config --global --add safe.directory /opt/project-name

cd /opt/project-name

ruff format --config pyproject.toml
ruff check --fix --config pyproject.toml
