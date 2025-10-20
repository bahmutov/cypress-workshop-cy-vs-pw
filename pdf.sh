#!/usr/bin/env bash

# convert each deployed presentation to a PDF file
# list of section names
sections=(
  "intro"
  "00-start"
  "01-basic"
  "02-adding-items"
  "03-completing-items"
  "04-test-ui"
  "05-hover"
  "06-network"
  "07-clock"
  "08-retries"
  "09-app-access"
  "10-ci"
  "11-component-tests"
  "end"
)

for section in "${sections[@]}"; do
  npx decktape reveal http://localhost:3100/?p="$section" pdf/"$section".pdf
done
