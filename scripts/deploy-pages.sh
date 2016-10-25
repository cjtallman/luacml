#!/bin/bash

GH_REPO="@github.com/cjtallman/luacml.git"
FULL_REPO="https://${GH_TOKEN}$GH_REPO"

pip install mkdocs

git remote add origin $FULL_REPO

mkdocs gh-deploy --clean
