## Component Tests

### 📚 You will learn

- why component testing
- Cypress native component testing
- Playwright "bridge" component testing

---

## Component testing

- [https://on.cypress.io/component](https://on.cypress.io/component)
  - [https://glebbahmutov.com/blog/how-cypress-component-testing-was-born/](https://glebbahmutov.com/blog/how-cypress-component-testing-was-born/)
- [https://playwright.dev/docs/test-components](https://playwright.dev/docs/test-components)

+++

## Playwright status

- `@playwright/experimental-ct-react`
- `@playwright/experimental-ct-svelte`
- `@playwright/experimental-ct-vue`

+++

![Cypress v14 component testing status](./img/cy-support.png)

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

## Use constants

- `git checkout g2`
- `npm install && npx playwright install`

Finish this Cypress component test

```js
// src/components/Button.cy.jsx
it('creates a Back button with an arrow image', () => {
  // mount the Button with the type prop set to "back"
  //
  // confirm that inside the button element with class "btn"
  // there is an image with alt text "Go back"
  // and the image loads its source without errors
})
```

+++

**Tip:** look at the image element's properties in the DevTools to check if it successfully loads (network, decoding, rendering)

+++

![Component DOM structure](./img/dom.png)

+++

## Cypress component test

```js
import Button from './Button'
import { BUTTON_TYPES } from './Button'
it('creates a Back button with an arrow image', () => {
  // mount the Button with the type prop set to "back"
  cy.mount(<Button label="Back" type={BUTTON_TYPES.BACK} />)
  // confirm that inside the button element with class "btn"
  // there is an image with alt text "Go back"
  // and the image loads its source without errors
  cy.get('button.btn')
    .find('img[alt="Go back"]')
    .should('have.prop', 'naturalWidth')
    .should('be.greaterThan', 0)
})
```

+++

![Back button image test](./img/check-image.png)

---

## Use constants

Finish this Playwright component test

```js
// src/components/Button.spec.jsx
import { test, expect } from '@playwright/experimental-ct-react17'
import Button from './Button'
test('creates a Back button with an arrow image', async ({ mount }) => {
  // mount the Button with the type prop set to "back"
  // confirm that inside the button element with class "btn"
  // there is an image with alt text "Go back"
  // and the image loads its source without errors
})
```

+++

```js
test('creates a Back button with an arrow image', async ({ mount }) => {
  const component = await mount(
    <Button label="Back" type={BUTTON_TYPES.BACK} />
  )
  const image = component.locator('img[alt="Go back"]')
  await expect(async () => {
    const width = await image.evaluate((node) => node.naturalWidth)
    expect(width, 'image width').toBeGreaterThan(0)
  }).toPass()
  // this solution could also work in this case
  await expect(image).not.toHaveJSProperty('naturalWidth', 0)
})
```

+++

![Playwright component test](./img/pw-natural-width.png)

+++

## Questions:

- what do you see when you run Cypress component test?
- what do you see when you run Playwright component test?

---

## Passing functional props

```js
const Button = ({
  customClass,
  label,
  onClick,
}) => {
  return (
    <button
      className={`btn${buttonTypeClass}${buttonSize}${extraClass}`}
      onClick={onClick}
```

Let's test the `onClick` prop when the user clicks the button.

+++

## Finish the Playwright test

- branch `g3`
- `npm install && npx playwright install`

```js
// src/components/Button.spec.jsx
test('callback prop is called on click', async ({ mount }) => {
  // keep track of the clicked state
  let clicked = false
  // mount the Button with the onClick prop set to a small function
  // that changes "clicked" to true
  //
  // click the button component
  // confirm the mock function was called
  // by checking if the "clicked" state is true
})
```

**Question:** what do you see during the test?

+++

```js
// src/components/Button.spec.jsx
test('callback prop is called on click', async ({ mount }) => {
  let clicked = false
  const component = await mount(
    <Button
      label="Test button"
      onClick={() => {
        clicked = true
      }}
    />
  )
  await component.click()
  expect(clicked, 'clicked').toBeTruthy()
})
```

+++

![Playwright stub](./img/clicked.png)

+++

## Finish the Cypress test

```js
// src/components/Button.cy.jsx
it('callback prop is called on click', () => {
  // mount the Button with the onClick function stub
  // https://on.cypress.io/stub
  // give the stub an alias "onClick"
  // https://on.cypress.io/as
  //
  // click the button component
  //
  // confirm the stub function was called
})
```

+++

```js
// src/components/Button.cy.jsx
it('callback prop is called on click', () => {
  cy.mount(<Button label="Test button" onClick={cy.stub().as('onClick')} />)
  cy.get('button').click()
  cy.get('@onClick').should('have.been.calledOnce')
})
```

+++

![Cypress callback](./img/stub.png)

---

## Async functional props

What if the component calls the functional prop `onClick` after some delay?

```js
// Instead of this
<button onClick={onClick}>
// We have an async call
onClick={() => setTimeout(onClick, 1000)}
```

+++

- check out branch `g4`
- `npm install`
- `npx playwright install`

Open test runners in the component testing modes; the `Button.jsx` component calls `onClick` after 1-second delay.

+++

## Modify Cypress test

```js
// src/components/Button.cy.jsx
it('callback prop is called on click', () => {
  // mount the Button with the onClick function stub
  // https://on.cypress.io/stub
  // give the stub an alias "onClick"
  // https://on.cypress.io/as
  cy.mount(<Button label="Test button" onClick={cy.stub().as('onClick')} />)
  // click the button component
  cy.get('button').click()
  // confirm the stub function was called
  cy.get('@onClick').should('have.been.calledOnce')
})
```

+++

**Cypress solution:** no changes necessary.

Note:
The assertion `cy.get('@onClick').should('have.been.calledOnce')` already retries until the stub function is called.

+++

![Cypress test when the callback is called after 1 second](./img/cy-async.gif)

+++

## Modify Playwright test

```js
// src/components/Button.spec.jsx
test('callback prop is called on click', async ({ mount }) => {
  let clicked = false
  const component = await mount(
    <Button
      label="Test button"
      onClick={() => {
        clicked = true
      }}
    />
  )
  await component.click()
  expect(clicked, 'clicked').toBeTruthy()
})
```

**Tip:** look at auto-retrying assertions in Playwright docs https://playwright.dev/docs/test-assertions#auto-retrying-assertions

+++

You must make the assertion `expect(clicked, 'clicked').toBeTruthy()` retry

```js
await expect
  .poll(
    () => {
      return clicked
    },
    { message: 'clicked' }
  )
  .toBeTruthy()
```

+++

![Playwright retries checking function stub](./img/pw-async.gif)

---

## Using Sinon.js library with Playwright

Let's add a powerful library for functional spies and stubs to make Playwright component tests easy to write.

- check out branch `g5`
- `npm install`
- `npx playwright install`

The dependencies include the `sinon` library

+++

## Use Sinon with Playwright

```js
// use Sinon.js library to create spies and stubs
// https://sinonjs.org/
import sinon from 'sinon'
const sandbox = sinon.createSandbox()
test.afterEach(() => {
  // reset all spies and stubs after each test
  sandbox.restore()
})
```

+++

Finish the test

```js
// src/components/Button.spec.jsx
test('callback prop is called on click', async ({ mount }) => {
  // mount the Button with the onClick prop set to a small function
  // that changes "clicked" to true
  // Tip: create the onClick function stub using the Sinon sandbox
  // click the button component
  // confirm the mock function "onClick" was called
})
```

+++

```js
// src/components/Button.spec.jsx
test('callback prop is called on click', async ({ mount }) => {
  // mount the Button with the onClick prop set to a small function
  // that changes "clicked" to true
  const onClick = sandbox.stub()
  const component = await mount(
    <Button label="Test button" onClick={onClick} />
  )
  // click the button component
  await component.click()
  // confirm the mock function "onClick" was called
  await expect.poll(() => onClick.calledOnce, { message: 'onClick' }).toBe(true)
})
```

+++

![Checking Sinon stub](./img/pw-sinon.png)

+++

## Check call arguments

```js
test('callback prop is called with arguments', async ({ mount }) => {
  // the Button component calls the "onClick" prop with a string
  // confirm the correct string is passed when the button is clicked
  // Tip: use the "stub.calledOnceWithExactly" method to check
})
```

+++

```js
test('callback prop is called with arguments', async ({ mount }) => {
  // the Button component calls the "onClick" prop with a string
  // confirm the correct string is passed when the button is clicked
  // Tip: use the "stub.calledOnceWithExactly" method to check
  const onClick = sandbox.stub()
  const component = await mount(
    <Button label="Test button" onClick={onClick} />
  )
  await component.click()
  await expect
    .poll(() => onClick.calledOnceWithExactly('Hello from button'), {
      message: 'onClick'
    })
    .toBe(true)
})
```

+++

## Compare solutions

```js
// Cypress
cy.mount(<Button label="Test button" onClick={cy.stub().as('onClick')} />)
cy.get('button').click()
cy.get('@onClick').should(
  'have.been.calledOnceWithExactly',
  'Hello from button'
)
// Playwright
const onClick = sandbox.stub()
const component = await mount(<Button label="Test button" onClick={onClick} />)
await component.click()
await expect
  .poll(() => onClick.calledOnceWithExactly('Hello from button'), {
    message: 'onClick'
  })
  .toBe(true)
```

---

## 🏁 Conclusions

- Cypress can run component tests the same way as its regular E2E tests
- Playwright creates a separate page with the component and "bridges" spec code to interact with the component <!-- .element: class="fragment" -->
- Cypress has functional assertions <!-- .element: class="fragment" -->
- Cypress component test interacts much more directly with the component <!-- .element: class="fragment" -->

➡️ Go to the [end](?p=end) chapter
