#!/usr/bin/env bash

# convert each deployed presentation to a PDF file
# npx decktape reveal https://glebbahmutov.com/cypress-workshop-cy-vs-pw/?p=intro pdf/intro.pdf
npx decktape reveal http://localhost:3100/ pdf/intro.pdf
