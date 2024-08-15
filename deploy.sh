#!/bin/bash

# Set environment variables
REPO_NAME="Jarvis-md"
GITHUB_TOKEN=${GITHUB_TOKEN}
GITHUB_USERNAME=${GITHUB_USERNAME}

# Build and deploy the project
npm run build
npm run deploy

# Create a new release
curl -X POST \
  https://api.github.com/repos/${GITHUB_USERNAME}/${REPO_NAME}/releases \
  -H 'Authorization: Bearer ${GITHUB_TOKEN}' \
  -H 'Content-Type: application/json' \
  -d '{"tag_name":"latest","target_commitish":"main","name":"Latest Release","body":"Automatically generated release notes"}'

# Upload the built files to the release
curl -X POST \
  https://api.github.com/repos/${GITHUB_USERNAME}/${REPO_NAME}/releases/latest/assets \
  -H 'Authorization: Bearer ${GITHUB_TOKEN}' \
  -H 'Content-Type: application/octet-stream' \
  -T dist/index.html

curl -X POST \
  https://api.github.com/repos/${GITHUB_USERNAME}/${REPO_NAME}/releases/latest/assets \
  -H 'Authorization: Bearer ${GITHUB_TOKEN}' \
  -H 'Content-Type: application/octet-stream' \
  -T dist/bundle.js
