## Completing Items

### 📚 You will learn

- Completing items test
- using JSON fixtures

---

- clean up the existing code
  - `git reset --hard`
  - `git clean -d -f`
- `git checkout b3`
- `npm install`

---

## Playwright: complete an item test

```js
// pw/complete.spec.js

const { test, expect } = require('@playwright/test')

test.describe('Complete todos', () => {
  test.beforeEach(async ({ request }) => {
    await request.post('/reset', { data: { todos: [] } })
  })

  test('completes a todo', async ({ page }) => {
    // common locators
    ...
    // enter three todos
    // "Write code", "Write tests", "Make tests pass"
    // confirm the item labels
    // confirm the "3" todos remaining is shown
    // complete the first item by clicking its toggle element
    // the first item should have class "completed"
    // confirm the 2nd and the 3rd items do not have class "completed"
    // Bonus: can you confirm classes for all 3 elements at once
    // confirm there are 2 remaining items
    // and that we can clear the completed items button appears
  })
})
```

+++

```js
// enter three todos
// "Write code", "Write tests", "Make tests pass"
await input.fill('Write code')
await input.press('Enter')
await input.fill('Write tests')
await input.press('Enter')
await input.fill('Make tests pass')
await input.press('Enter')

// confirm the item labels
await expect(todoLabels).toHaveText([
  'Write code',
  'Write tests',
  'Make tests pass'
])
// confirm the "3" todos remaining is shown
await expect(count).toHaveText('3')

// complete the first item by clicking its toggle element
await todos.first().locator('.toggle').click()
// the first item should have class "completed"
await expect(todos.first()).toHaveClass(/completed/)
// confirm the 2nd and the 3rd items do not have class "completed"
await expect(todos.nth(1)).not.toHaveClass(/completed/)
await expect(todos.nth(2)).not.toHaveClass(/completed/)
// Bonus: can you confirm classes for all 3 elements at once
await expect(todos).toHaveClass(['todo completed', 'todo', 'todo'])
// confirm there are 2 remaining items
await expect(count).toHaveText('2')
// and that we can clear the completed items button appears
await expect(
  page.getByRole('button', { name: 'Clear completed' })
).toBeVisible()
```

+++

I really ❤️ Playwright's `toHaveText` assertion

```js
await expect(todoLabels).toHaveText([
  'Write code',
  'Write tests',
  'Make tests pass'
])
```

In Cypress I would use [cypress-map](https://github.com/bahmutov/cypress-map) to write similar but more limited

```js
cy.get(todoLabels)
  .map('innerText')
  .should('deep.equal', ['Write code', 'Write tests', 'Make tests pass'])
```

---

## Cypress: complete an item test

```js
cy.visit('/')
cy.get('body.loaded').should('be.visible')

// enter three todos
// "Write code", "Write tests", "Make tests pass"
// confirm the item labels
// confirm the "3" todos remaining is shown
// complete the first item by clicking its toggle element
// the first item should have class "completed"
// confirm the 2nd and the 3rd items do not have class "completed"
// Bonus: can you confirm classes for all 3 elements at once
// confirm there are 2 remaining items
// and that we can clear the completed items button appears
```

+++

```js
// enter three todos
// "Write code", "Write tests", "Make tests pass"
cy.get(input)
  .type('Write code{enter}')
  .type('Write tests{enter}')
  .type('Make tests pass{enter}')

// confirm the item labels
cy.get(todoLabels)
  .should('have.length', 3)
  .then(($el) => Cypress._.map($el, 'innerText'))
  .should('deep.equal', ['Write code', 'Write tests', 'Make tests pass'])
// confirm the "3" todos remaining is shown
cy.contains(count, 3)

// complete the first item by clicking its toggle element
cy.get(todos).first().find('.toggle').click()
// the first item should have class "completed"
cy.get(todos).first().should('have.class', 'completed')
// confirm the 2nd and the 3rd items do not have class "completed"
cy.get(todos).eq(1).should('not.have.class', 'completed')
cy.get(todos).eq(2).should('not.have.class', 'completed')
// Bonus: can you confirm classes for all 3 elements at once
cy.get(todos)
  .then(($el) => Cypress._.map($el, 'classList.value'))
  .should('deep.equal', ['todo completed', 'todo', 'todo'])
// confirm there are 2 remaining items
cy.contains(count, 2)
// and that we can clear the completed items button appears
cy.contains('button', 'Clear completed').should('be.visible')
```

---

## Use JSON fixtures

- `git checkout b4`

Adds `fixtures/three.json` with 3 todo items

```json
[
  {
    "title": "Write code",
    "completed": false,
    "id": "1"
  },
  {
    "title": "Write tests",
    "completed": false,
    "id": "2"
  },
  {
    "title": "Make tests pass",
    "completed": false,
    "id": "3"
  }
]
```

---

## Use JSON fixture in Playwright

Update the `pw/complete.spec.js` file to reset the initial data using `fixtures/three.json` and remove the hard-coded values

```js
// complete.spec.js
test.describe('Complete todos', () => {
  test.beforeEach(async ({ request }) => {
    request.post('/reset', { data: { todos: [] } })
  })

  test('completes a todo', async ({ page }) => {
    // common locators
    const input = page.getByPlaceholder('What needs to be done?')
    const todos = page.locator('.todo-list li')
    const todoLabels = todos.locator('label')
    const count = page.locator('[data-cy="remaining-count"]')

    await page.goto('/')
    await page.locator('body.loaded').waitFor()

    // enter three todos
    // "Write code", "Write tests", "Make tests pass"
    await input.fill('Write code')
    await input.press('Enter')
    await input.fill('Write tests')
    await input.press('Enter')
    await input.fill('Make tests pass')
    await input.press('Enter')

    // confirm the item labels
    await expect(todoLabels).toHaveText([
      'Write code',
      'Write tests',
      'Make tests pass',
    ])
    ...
  })
})
```

+++

## Playwright script runs in Node

```js
const { test, expect } = require('@playwright/test')
const items = require('../fixtures/three.json')

test.describe('Complete todos', () => {
  test.beforeEach(async ({ request }) => {
    await request.post('/reset', { data: { todos: items } })
  })

  test('completes a todo', async ({ page }) => {
    // common locators
    const todos = page.locator('.todo-list li')
    const todoLabels = todos.locator('label')
    const count = page.locator('[data-cy="remaining-count"]')

    await page.goto('/')

    // confirm the item labels
    const labels = items.map((t) => t.title)
    await expect(todoLabels).toHaveText(labels)
    // confirm the N todos remaining is shown
    await expect(count).toHaveText(String(items.length))

    // complete the first item by clicking its toggle element
    await todos.first().locator('.toggle').click()
    // the first item should have class "completed"
    await expect(todos.first()).toHaveClass(/completed/)
    // confirm the 2nd and the 3rd items do not have class "completed"
    await expect(todos.nth(1)).not.toHaveClass(/completed/)
    await expect(todos.nth(2)).not.toHaveClass(/completed/)
    // Bonus: can you confirm classes for all 3 elements at once
    await expect(todos).toHaveClass(['todo completed', 'todo', 'todo'])
    // confirm there are N-1 remaining items
    await expect(count).toHaveText(String(items.length - 1))
    // and that we can clear the completed items button appears
    await expect(
      page.getByRole('button', { name: 'Clear completed' })
    ).toBeVisible()
  })
})
```

---

## JSON fixtures in Cypress

Update the `cypress/e2e/complete.cy.js` spec to use the `fixtures/three.json` data

💡 You can directly require or import JSON files or use the [cy.fixture](https://on.cypress.io/fixture) command

+++

```js
// cypress/e2e/complete.cy.js

import items from '../../fixtures/three.json'

describe('Complete todos', () => {
  beforeEach(() => {
    // immediately create 3 todos
    // using the JSON file "fixtures/three.json"
    cy.request('POST', '/reset', { todos: items })
  })

  it('completes a todo', () => {
    // common locators
    const todos = '.todo-list li'
    const todoLabels = todos + ' label'
    const count = '[data-cy="remaining-count"]'

    cy.visit('/')

    // confirm the item labels
    const labels = items.map((t) => t.title)

    cy.get(todoLabels)
      .should('have.length', items.length)
      .then(($el) => Cypress._.map($el, 'innerText'))
      .should('deep.equal', labels)
    // confirm the number of todos remaining is shown
    cy.contains(count, items.length)

    // complete the first item by clicking its toggle element
    cy.get(todos).first().find('.toggle').click()
    // the first item should have class "completed"
    cy.get(todos).first().should('have.class', 'completed')
    // confirm the 2nd and the 3rd items do not have class "completed"
    cy.get(todos).eq(1).should('not.have.class', 'completed')
    cy.get(todos).eq(2).should('not.have.class', 'completed')
    // Bonus: can you confirm classes for all 3 elements at once
    cy.get(todos)
      .then(($el) => Cypress._.map($el, 'classList.value'))
      .should('deep.equal', ['todo completed', 'todo', 'todo'])
    // confirm there are N - 1 remaining items
    cy.contains(count, items.length - 1)
    // and that we can clear the completed items button appears
    cy.contains('button', 'Clear completed').should('be.visible')
  })
})
```

Cypress JSON fixture solution

---

## 🏁 Lessons learned

- use JSON fixtures to quickly set the initial state
- avoids UI test duplication

➡️ Pick the [next section](https://github.com/bahmutov/cypress-workshop-cy-vs-pw#contents) or jump to the [04-reset-state](?p=04-reset-state) chapter
