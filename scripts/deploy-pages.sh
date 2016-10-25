#!/bin/bash

FULL_REPO="https://$GH_TOKEN@github.com/cjtallman/luacml.git"

git remote set-url origin $FULL_REPO

pip install mkdocs

mkdocs gh-deploy --clean
