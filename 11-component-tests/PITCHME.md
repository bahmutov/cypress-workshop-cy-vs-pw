## Component Tests

### 📚 You will learn

- why component testing
- Cypress native component testing
- Playwright "bridge" component testing

---

## Button component

```jsx
const Button = ({ customClass, label, onClick }) => {
  return (
    <button
      className={`btn${buttonTypeClass}${buttonSize}${extraClass}`}
      onClick={onClick}
    >
      ...
    </button>
  )
}
```

How would you test all possible behaviors of this button?

+++

```jsx
const Button = ({ customClass, label, onClick }) => {
```

Testing such button through E2E is hard, since the pages might only use a limited number of button's features.

Component tests to the rescue!<!-- .element: class="fragment" -->

+++

## Component tests

- small tests mounting a single front-end component (React, Vue, Angular, Svelte, etc)
- interacting with the "live" component
- checking the expected results:
  - DOM changes
  - network calls
  - prop callbacks

+++

## E2E vs Component Tests

- slow vs fast
- user story vs component
- web app vs component

---

## Example

- clone repo `https://github.com/bahmutov/taste-the-sauce-vite`
- check out branch `g1`
- `npm install`
- `npx playwright install`

---

## Todo: Write Cypress component test

```js
// src/components/Button.cy.jsx

import React from 'react'
import Button from './Button'

it('shows a button', () => {
  // use the cy.mount command to mount the Button component
  // with the prop `label` set to 'Test button'
  // confirm the page contains a button with the text 'Test button'
})
```

**Tip:** run Cypress in the component mode `npx cypress open --component`

**Tip 2:** look at the component support file `cypress/support/component.jsx`

+++

```js
// src/components/Button.cy.jsx

import React from 'react'
import Button from './Button'

it('shows a button', () => {
  // use the cy.mount command to mount the Button component
  // with the prop `label` set to 'Test button'
  cy.mount(<Button label="Test button" />)
  // confirm the page contains a button with the text 'Test button'
  cy.contains('button', 'Test button')
})
```

+++

![Button component test](./img/button-test.png)

+++

![Button DOM](./img/button-dom.png)

---

## Todo: Write Playwright component test

```js
// src/components/Button.spec.jsx

import { test, expect } from '@playwright/experimental-ct-react17'
import Button from './Button'

test('shows a button', async ({ mount }) => {
  // use the mount command to mount the Button component
  // with the prop `label` set to 'Test button'
  // confirm the component contains text 'Test button'
})
```

**Tip:** run the component spec in UI mode with `npm run test-ct -- --ui`

+++

```js
// src/components/Button.spec.jsx

import { test, expect } from '@playwright/experimental-ct-react17'
import Button from './Button'

test('shows a button', async ({ mount }) => {
  // use the mount command to mount the Button component
  // with the prop `label` set to 'Test button'
  const component = await mount(<Button label="Test button" />)
  // confirm the component contains text 'Test button'
  await expect(component).toContainText('Test button')
})
```

+++

![Playwright component test](./img/pw.png)

---

## 🏁 Conclusions

- Cypress can run component tests the same way as its regular E2E tests
- Playwright creates a separate page with the component and "bridges" spec code to interact with the component
