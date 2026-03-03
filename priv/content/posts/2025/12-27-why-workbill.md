%{
  title: "Why I am building a new accounting platform for small-businesses",
  tags: ~w(workbill),
  description: "Why I am building WorkBill, and why it should exist.",
  draft: true,
rating: 2
}

---

I have been building [WorkBill](https://workbill.co) for over two months now, and I think it's finally to talk about why I am building it and why it needs to exist in this world.

## Why I love double-entry accounting
I had been using [Beancount](https://github.com/beancount) to track my personal finances for the last three years. Unlike the myraid of personal finance trackers on the market who could only assign a category to each transaction, Beancount was based on double-entry accounting, which meant I could represent complex transactions easily, even when beancount didn't have any explicit support for it.

For example, for a transaction, where I paid 500Rs for fuel, where I paid 250Rs from my bank account, and 250Rs was lent by my friend. In a single-entry personal finance app, it would only see the 250Rs from the bank transaction, and can assign a category of fuel to it. There is no representation of the true cost of the fuel 500Rs, the 250Rs I owe to the friend and the fact that these are all part of a single transaction.

With beancount and double-entry accounting, we can represent the transaction as a whole.
```
2025-09-25 * "Fuel for Car"
  Expenses:Car:Fuel                      500 INR
  Assets:IN:Personal:Cash:Axis:Savings  -250 INR  
  Liabilities:Amith                     -250 INR  
```

In a single journal entry, we were able to represent the complex transaction. When combined with the rule that the entries should sum to zero, we can catch errors much more easily than single entry transactions.


## Why I love BeanCount
Representing complex transactions and validation them could be done by any double-entry based accounting system. The feature which sets BeanCount apart is the nested account names. Account names can be of five types, `Equity`, `Income`, `Asset`, `Expense`, `Liability`. You can nest accounts under each other by nesting the account names. `Asset:US:Cash:Chase:Current` and `Assets:US:Cash:Chase:Treasury` both would be nested under `Assets:US:Cash:Chase`.

This helps us to build out our chart of accounts however we want, with any sort of
