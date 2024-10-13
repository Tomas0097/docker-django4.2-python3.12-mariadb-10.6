#!/bin/bash

set -e

cd /opt/project-name

pip3 install -U pip
pip3 install --no-cache-dir -r requirements.txt
