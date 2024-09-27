## Clock control

### 📚 You will learn

- speed up tests by fast-forwarding timers
- control the application clock and date

+++

- clean up the existing code
  - `git reset --hard`
  - `git clean -d -f`
- `git checkout e9`
- `npm install`

---

## Clock APIs

Playwright v1.45+ has [Clock API](https://playwright.dev/docs/clock) and Cypress has the [cy.clock](https://on.cypress.io/clock) command. Let's use it to "fast forward" time to fire the interval timers quicker.

```js
// app.js
// how would you test the periodic loading of todos?
setInterval(() => {
  this.$store.dispatch('loadTodos')
}, 60_000)
```

---

## Playwright

```js
// pw/clock.spec.js
const { test, expect } = require('@playwright/test')

test.describe('App', () => {
  test('fetches todos every 60 seconds', async ({ page }) => {
    // install synthetic clock using clock.install
    // https://playwright.dev/docs/clock

    // spy on the "/todos" network request
    await page.goto('/')
    // confirm the application fetches the "/todos" endpoint

    // spy on the "/todos" network request again
    // advance the fake timers by 61 seconds
    // using clock.runFor
    // and confirm the application fetches the "/todos" endpoint again

    // spy on the "/todos" network request again
    // advance the fake timers by 61 seconds
    // and confirm the application fetches the "/todos" endpoint 3rd time
  })
})
```

Can you confirm the app is making `GET /todos` calls every minute?

+++

```js
const { test } = require('@playwright/test')

test.describe('App', () => {
  test('fetches todos every 60 seconds', async ({ page }) => {
    // https://playwright.dev/docs/clock
    await page.clock.install()

    const loadTodos1 = page.waitForRequest('/todos')
    await page.goto('/')
    await loadTodos1

    const loadTodos2 = page.waitForRequest('/todos')
    await page.clock.runFor(61_000)
    await loadTodos2

    const loadTodos3 = page.waitForRequest('/todos')
    await page.clock.runFor(61_000)
    await loadTodos3
  })
})
```

We instantly "run" the clock using `await page.clock.runFor(61_000)`

---

## Cypress

```js
// cypress/e2e/clock.cy.js
describe('App', () => {
  it('fetches todos every 60 seconds', () => {
    // spy on the "GET /todos" requests and
    // give them an alias "loadTodos"
    // https://on.cypress.io/intercept
    cy.intercept('GET', '/todos').as('loadTodos')
    // control the application's clock
    // https://on.cypress.io/clock
    cy.visit('/')
    // confirm the application called the "loadTodos" endpoint
    // Tip: you can even use a short 100ms timeout
    cy.wait('@loadTodos', { timeout: 100 })
    // advance the application's clock by 61 seconds
    // https://on.cypress.io/tick
    // confirm the application called the "loadTodos" endpoint

    // advance the application's clock by another 61 seconds
    // confirm the application called the "loadTodos" endpoint
  })
})
```

+++

```js
describe('App', () => {
  it('fetches todos every 60 seconds', () => {
    cy.intercept('GET', '/todos').as('loadTodos')
    cy.clock()
    cy.visit('/')
    cy.wait('@loadTodos', { timeout: 100 })

    cy.tick(61_000)
    cy.wait('@loadTodos', { timeout: 100 })

    cy.tick(61_000)
    cy.wait('@loadTodos', { timeout: 100 })
  })
})
```

Cypress solution

---

## Set specific date and time

Cypress: `cy.clock(new Date(2021, 3, 14))`

Playwright: `page.clock.setFixedTime(new Date(2021, 3, 14))`

---

## 🏁 Control application clock

- set any date
- pause / fast-forward timers

➡️ Pick the [next section](https://github.com/bahmutov/cypress-workshop-basics#contents) or jump to the [08-retries](?p=08-retries) chapter
