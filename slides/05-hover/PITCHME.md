## Delete Items

### 📚 You will learn

- how to force-click an item
- how to execute element hover
- how to test deleting items

---

- clean up the existing code
  - `git reset --hard`
  - `git clean -d -f`
- `git checkout b7`
- `npm install`

---

## Deleting items

**Question:** how does the user delete an item?

---

## Test deleting items in Playwright

```js
// pw/delete-items.spec.js

test('deletes items', async ({ page }) => {
  // common locators
  const todos = page.locator('.todo-list li')
  await page.goto('/')
  await expect(todos).toHaveCount(3)

  // delete one completed item (the middle one)
  // confirm the remaining two items are still there
  // delete one incomplete item (the first one)
  // confirm the one remaining item
})
```

+++

```js
test('deletes items', async ({ page }) => {
  // common locators
  const todos = page.locator('.todo-list li')
  await page.goto('/')
  await expect(todos).toHaveCount(3)
  // delete one completed item (the middle one)
  await todos.nth(1).hover()
  await todos.nth(1).locator('.destroy').click()
  // confirm the remaining two items are still there
  await expect(todos).toHaveCount(2)
  await expect(todos).toHaveText(['Write code', 'Make tests pass'])
  // delete one incomplete item (the first one)
  await todos.nth(0).hover()
  await todos.nth(0).locator('.destroy').click()
  // confirm the one remaining item
  await expect(todos).toHaveCount(1)
  await expect(todos).toHaveText(['Make tests pass'])
})
```

Playwright solution includes `hover()` command

---

## Test deleting items in Cypress

```js
// cypress/e2e/delete-items.cy.js

it('deletes items', () => {
  // common locators
  const todos = '.todo-list li'

  cy.visit('/')
  cy.get(todos).should('have.length', 3)

  // delete one completed item (the middle one)
  // confirm the remaining two items are still there
  // delete one incomplete item (the first one)
  // confirm the one remaining item
})
```

**Tip:** you can force-click a button without it being visible, see [cy.click](https://on.cypress.io/click)

+++

```js
it('deletes items', () => {
  // common locators
  const todos = '.todo-list li'

  cy.visit('/')
  cy.get(todos).should('have.length', 3)
  // delete one completed item (the middle one)
  cy.get(todos)
    .eq(1)
    .find('.destroy')
    // skip visibility check
    .click({ force: true })
  // confirm the remaining two items are still there
  cy.get(todos)
    .should('have.length', 2)
    .then(($li) => Cypress._.map($li, 'innerText'))
    .should('deep.equal', ['Write code', 'Make tests pass'])
  // delete one incomplete item (the first one)
  cy.get(todos)
    .first()
    .find('.destroy')
    // skip visibility check
    .click({ force: true })
  // confirm the one remaining item
  cy.get(todos).should('have.length', 1).contains('Make tests pass')
})
```

---

## Hover command in Cypress

"Hover" is a _native_ browser command / event and cannot be simulated using JavaScript (which is what Cypress commands are). Luckily, there is a Cypress plugin [cypress-real-events](https://github.com/dmtrKovalenko/cypress-real-events) that implements it.

- `git checkout b8`

+++

```js
// cypress/e2e/delete-items.cy.js

// can you hover of the todo item
// and avoid using .click({ force: true })
cy.get(todos).eq(1).find('.destroy').click({ force: true })
```

Can you update the test to use the `cypress-real-events` plugin and call `.hover()`?

+++

## Cypress `hover` command

- Install the plugin using `$ npm i -D cypress-real-events`
- Import it from the spec `import 'cypress-real-events'`
- use new child command `cy.realHover`

```js
cy.get(todos).eq(1).realHover().find('.destroy').click()
```

---

## Deleting items

- Playwright has built-in native events like `hover`
- Cypress can send native events via a plugin

➡️ Pick the [next section](https://github.com/bahmutov/cypress-workshop-basics#contents) or jump to the [05-network](?p=05-network) chapter
