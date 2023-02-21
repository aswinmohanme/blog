%{
  title: "How does UPI work ? A Technical Perspective.",
  tags: ~w(payments how india),
  description: "Learn about UPI works under the hood. What happens when you send money to your friends, how payments are handled at the merchant level as well.",
  draft: true
}
---

UPI or United Payments Interface is the ubiquitous payment method in India. Learn how it works under the hood.

## The User Experience of UPI
If you haven't used UPI and have only heard about it, this is how the UPI works.

* The Payer (person who wants to pay) opens up their UPI app and enters the UPI Id or scans the QR code of the Payee (person who receives the payment)
* The Payer then enters the amount and selects the bank account that they want to send the money from
* The UPI app then asks for the UPI pin and in around three seconds the money is sent.


## How a UPI transaction takes place.
Rather than go through the entire terms of the ecosystem, let's start with two people who wants to make a UPI transaction and build it from first principles. 

In the true spirit of Indian Government ads, let's start with Ramu and Damu. Ramu wants to send Damu Rs.100. Let's see how the transaction takes place from the first step to the last step and we'll introduce the different entities along the way. We'll introduce different UPI concepts and how it works along the transaction.


## The world of Ramu and Damu
Before we start with the transaction, let's establish the world where Ramu and Damu lives in. Ramu and Damu are living in India. Ramu has an account with SBI and Damu has an account with Yes Bank. Ramu and Damu both has an account balance of Rs.1000.

## Ramu wants to send money to Damu
Damu had lend Rs.100 Ramu for his son's birthday and Ramu decided to pay Damu via UPI. Ramu opens up his UPI app to start the payment process.

### UPI Apps
UPI Apps are the consumer facing side of the UPI network. Users interact with the network through these Apps.

## Finding Damu
Ramu now needs to find Damu on the UPI network so the money reaches him safely.

### VPA - Virtual Payment Address
Every person on the UPI network will have a unique address identifying them. The VPA is a combination of a user identifier and an entity identifier that identifies the issuing bank separated by a `@` symbol, like `ramu@sbi` and `damu@yes`. The VPA uniquely identifies the UPI account. A single bank account can have multiple VPA's associated with them.


## Resources
* UPI Product Booklet - https://www.npci.org.in/PDF/npci/upi/Product-Booklet.pdf
