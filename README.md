# Cash Register API (Rails Backend)

This is the Rails API backend for the **Cash Register App**, a test-driven discount and checkout engine. It supports business rules such as Buy-One-Get-One, Bulk Discounts, and Volume Discounts, and serves a React frontend via RESTful APIs.

---

## 🚀 Features

* ✅ Session-based cart management
* ✅ Product catalog (`GR1`, `SR1`, `CF1`)
* ✅ Promotions:

  * **Buy-One-Get-One** (GR1)
  * **Bulk Discount**: SR1, discounted price when buying 3 or more
  * **Volume Discount**: CF1, 2-for-3 pricing when buying 3 or more
* ✅ JSON API endpoints for frontend integration
* ✅ TDD with RSpec
* ✅ CORS-ready for React frontend at `localhost:3001`

---

## 📦 Installation

Clone the repo:

```bash
git clone git@github.com:hyperplayer7/cash_register2025.git
cd cash_register2025
bundle install
rails db:create db:migrate db:seed
rails s
```
---

## 🔌 API Endpoints

| Method | Endpoint             | Description           |
| ------ | -------------------- | --------------------- |
| GET    | `/api/products`      | List all products     |
| GET    | `/api/cart`          | Show cart with totals |
| POST   | `/api/cart/add_item` | Add item by code      |
| DELETE | `/api/cart/empty`    | Empty the cart        |

Example payload for `POST /api/cart/add_item`:

```json
{
  "code": "GR1"
}
```

---

## 🌐 CORS

Ensure CORS is enabled for frontend access (`http://localhost:3001`). This is configured via the `rack-cors` gem in `config/initializers/cors.rb`.

---

## 🧪 Tests

Run the full test suite:

```bash
bundle exec rspec
```

Includes specs for:

* Cart logic (`spec/services/cart_spec.rb`)
* Promotions (`spec/services/rule/`)
* API endpoints (`spec/requests/api/`)

### ✅ Linting with RuboCop

RuboCop is used to enforce Ruby style and coding standards.

Run RuboCop:

```bash
bundle exec rubocop
```

To auto-correct offenses:

```bash
bundle exec rubocop -A
```

You can customize rules via the `.rubocop.yml` file.

---

## 🛠️ Development

Start the server:

```bash
bin/rails s
```

It runs on **port 3000**.

---

## 🧩 React Frontend

A separate React frontend connects to this API. Make sure React is running on `localhost:3001` to avoid CORS issues.

---

## 🧑‍💻 Author

**hyperplayer7**
GitHub: [github.com/hyperplayer7](https://github.com/hyperplayer7)

---

## 📄 License

This project is for educational and demonstration purposes.
