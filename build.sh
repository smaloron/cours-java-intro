#!/bin/sh

mkdir docs

unzip webHelpJI2-all.zip -d docs

git subtree push --prefix docs origin gh-pages