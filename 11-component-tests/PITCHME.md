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

**Tip:** run the component spec in UI mode with `npm run test-ct -- --ui`. **Important ⚠️**: the `ctPort` in the Pw config must point at an unused port.

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

## TODO: test other props

```js
// src/components/Button.cy.jsx

it('passes custom class name', () => {
  // mount the Button with the customClass prop set to "myClass"
  // confirm the page contains a button with the class "myClass"
})

it('sets the test id', () => {
  // mount the Button with the testId prop set to "myTestId"
  // confirm the button with the text "Test button" has
  // the data-test, name, and id set to "myTestId"
})
```

+++

```js
// src/components/Button.cy.jsx
it('passes custom class name', () => {
  cy.mount(<Button label="Test button" customClass="myClass" />)
  cy.get('button.myClass')
})

it('sets the test id', () => {
  cy.mount(<Button label="Test button" testId="myTestId" />)
  cy.contains('button', 'Test button')
    .should('have.id', 'myTestId')
    .and('have.attr', 'name', 'myTestId')
    .and('have.attr', 'data-test', 'myTestId')
})
```

+++

![Button tests Cypress](./img/button-tests-cy.png)

+++

```js
// src/components/Button.spec.jsx

test('passes custom class name', async ({ mount }) => {
  // mount the Button with the customClass prop set to "myClass"
  // confirm the page contains a button with the class "myClass"
})

test('sets the test id', async ({ mount }) => {
  // mount the Button with the testId prop set to "myTestId"
  // confirm the button with the text "Test button" has
  // the data-test, name, and id set to "myTestId"
})
```

+++

```js
// src/components/Button.spec.jsx

test('passes custom class name', async ({ mount }) => {
  const component = await mount(
    <Button label="Test button" customClass="myClass" />
  )
  await expect(component).toHaveClass(/myClass/)
})

test('sets the test id', async ({ mount }) => {
  const component = await mount(
    <Button label="Test button" testId="myTestId" />
  )
  await expect(component).toHaveAttribute('data-test', 'myTestId')
  await expect(component).toHaveAttribute('name', 'myTestId')
  await expect(component).toHaveAttribute('id', 'myTestId')
})
```

+++

![Button tests Playwright](./img/button-tests-pw.png)

---

## Config differences for component testing

Cypress has a single config for both E2E and component testing

```js
// cypress.config.js
import { defineConfig } from 'cypress'
export default defineConfig({
  e2e: {},
  component: {}
})
```

+++

Playwright has separate configs and test syntax

```js
// Playwright e2e config file
import { defineConfig, devices } from '@playwright/test'
// Playwright component config file
import { defineConfig, devices } from '@playwright/experimental-ct-react17'
```

+++

Playwright provides different `test` and `expect` for component testing

```js
// Playwright E2E specs
import { test, expect } from '@playwright/test'
// Playwright component spec
import { test, expect } from '@playwright/experimental-ct-react17'
```

---

## 🏁 Conclusions

- Cypress can run component tests the same way as its regular E2E tests
- Playwright creates a separate page with the component and "bridges" spec code to interact with the component
