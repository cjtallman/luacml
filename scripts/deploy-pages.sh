#!/bin/bash

pip install mkdocs

git config user.name "Chris Tallman"
git config user.email "${GH_EMAIL}"
git remote add upstream "https://${GH_TOKEN}@github.com/cjtallman/luacml.git"

mkdocs gh-deploy --clean --remote-name upstream
