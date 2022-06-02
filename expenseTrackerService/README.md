
## API Reference

### Expenses' categories

#### Get all categories

```
GET /api/categories
```

#### Get category

```
GET /api/categories/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `long` | **Required**. Id of category to fetch |


#### Post category
```
POST /api/categories/
```
Example request body:
```json
{
  "name": "Food",
  "icon": "🍏"
}
```

#### Patch category
```
PATCH /api/categories/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `long` | **Required**. Id of category to update |

Example request body:
```json
{
  "name": "Food",
  "icon": "🍎"
}
```

#### Delete category
```
DELETE /api/categories/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `long` | **Required**. Id of category to delete |

### Expenses

#### Get all expenses

```
GET /api/expenses
```

#### Get all expenses for chosen category

```
GET /api/expenses/categoryId=${categoryId}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `categoryId`      | `long` | **Required**. Id of category for expenses to fetch |


#### Get expense

```
GET /api/expenses/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `long` | **Required**. Id of expense to fetch |


#### Post expense
```
POST /api/expenses/categoryId=${categoryId}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `categoryId`      | `long` | **Required**. Id of category for expense |


Example request body:
```json
{
  "name": "Paella",
  "amount": "14.50",
  "currency": "EUR",
  "expenseDate": "2022-04-21",
  "unnecessary": false
}
```

#### Patch expense
```
PATCH /api/expenses/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `long` | **Required**. Id of expense to update |

Example request body:
```json
{
  "name": "Paella",
  "amount": "14.50",
  "currency": "EUR",
  "expenseDate": "2022-04-21",
  "unnecessary": true
}
```

#### Delete expense
```
DELETE /api/expenses/categoryId=${categoryId}/expenseId=${expenseId}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `categoryId`      | `long` | **Required**. Id of category, which contain expense to delete |
| `expenseId`      | `long` | **Required**. Id of expense to delete |


