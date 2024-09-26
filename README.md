# cypress-workshop-cy-vs-pw

> Cypress Vs Playwright Basics Workshop

## Introduction

This workshop teaches you how to write Cypress and Playwright tests using the same hands-on exercises.

## Requirements

- Any computer: Mac, Windows, Linux
- [Node 20+ (LTS)](https://nodejs.org/), see my [Node install video](https://youtu.be/09KbTRLrgWA), and my [Node versions using NVM video](https://youtu.be/CNnCz6StbbY)
- [git](https://git-scm.com)

Check the Node version

```
$ node -v
# for example v20.11.0
$ npm -v
# for example 10.2.4
```

### Example application

We will practice using the TodoMVC application I have prepared in the [bahmutov/cy-vs-pw-example-todomvc](https://github.com/bahmutov/cy-vs-pw-example-todomvc) repo.

```bash
git clone git@github.com:bahmutov/cy-vs-pw-example-todomvc.git
cd cy-vs-pw-example-todomvc
```

In every lesson we will use _a branch_ in the "cy-vs-pw-example-todomvc" repo with the starting code.

## Slides

The slides are deployed to GitHub Pages and can be seen at [https://glebbahmutov.com/cypress-workshop-cy-vs-pw/](https://glebbahmutov.com/cypress-workshop-cy-vs-pw/).

The slides can be seen locally by running `npm start` and opening `localhost:3100`. The content for the slides comes from the Markdown files in the [slides](./slides) folder. Read [Presentations with Reveal.js and Vite](https://glebbahmutov.com/blog/reveal-vite/) for technical details.

## Contents

<!-- prettier-ignore-start -->
Topic | The Markdown | See the slides
---|---|---
Introduction | [intro.md](slides/intro/PITCHME.md) | [link](https://glebbahmutov.com/cypress-workshop-cy-vs-pw/?p=intro)
Start testing | [00-start.md](slides/00-start/PITCHME.md) | [link](https://glebbahmutov.com/cypress-workshop-cy-vs-pw/?p=00-start)
Basic tests | [01-basic.md](slides/01-basic/PITCHME.md) | [link](https://glebbahmutov.com/cypress-workshop-cy-vs-pw/?p=01-basic)
Adding items | [02-adding-items.md](slides/02-adding-items/PITCHME.md) | [link](https://glebbahmutov.com/cypress-workshop-cy-vs-pw/?p=02-adding-items)
Completing items | [03-completing-items.md](slides/03-completing-items/PITCHME.md) | [link](https://glebbahmutov.com/cypress-workshop-cy-vs-pw/?p=03-completing-items)
Test UI | [04-test-ui.md](slides/04-test-ui/PITCHME.md) | [link](https://glebbahmutov.com/cypress-workshop-cy-vs-pw/?p=04-test-ui)
Hover | [05-hover.md](slides/05-hover/PITCHME.md) | [link](https://glebbahmutov.com/cypress-workshop-cy-vs-pw/?p=05-hover)
The end | [end](slides/end/PITCHME.md) | [link](https://glebbahmutov.com/cypress-workshop-cy-vs-pw/?p=end)
Network testing | [06-network.md](slides/06-network/PITCHME.md) | [link](https://glebbahmutov.com/cypress-workshop-cy-vs-pw/?p=06-network)
The end | [end](slides/end/PITCHME.md) | [link](https://glebbahmutov.com/cypress-workshop-cy-vs-pw/?p=end)
<!-- prettier-ignore-end -->

## Additional information

- https://cypress.tips/
- https://glebbahmutov.com/cypress-examples/
- https://www.youtube.com/glebbahmutov
- https://slides.com/bahmutov
- https://cypresstips.substack.com/
- 📝 read [Cypress TodoMVC Questions Answered](https://glebbahmutov.com/blog/cypress-todomvc-questions/)
- ✅ [Cypress Skills Checklist](https://cypress.tips/skills)
- https://docs.cypress.io/

## Other workshops

If your organization is interested in learning about Cypress in depth, please contact me. Besides this "Cypress Basics" workshop, I also regularly teach the following workshop.

- https://github.com/bahmutov/cypress-workshop-basics
- https://github.com/bahmutov/cypress-visual-testing-workshop
- https://github.com/bahmutov/cypress-workshop-ci
- https://github.com/bahmutov/cypress-workshop-socketio-chat

Of course, I can customize a workshop to your needs. Take a look at https://cypress.tips/workshops

## Author

Gleb Bahmutov has PhD in Computer Science and has worked at Cypress.io for four years as VP of Engineering and Distinguished Engineer, and was heavily involved in all areas of the Test Runner development, as well as Cypress Dashboard features, plugin writing, and CI integration. He has spoken about Cypress approximately a hundred times at meetups and conferences, wrote 100s of blog posts about testing, and has recorded more than 700 Cypress videos available for free on his YouTube channel. Today, Gleb is still heavily using Cypress at a large company making sure its web applications are always working correctly.
