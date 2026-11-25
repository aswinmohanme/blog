%{
  title: "Theory of constraints and building a startup",
  tags: ~w(startup),
  description: "How to apply the theory of constraints to build a startup and where to focus first. TL;DR: Sell first before building.",
  published: true
}

---

The theory of constraints from the book [The Goal](https://en.wikipedia.org/wiki/The_Goal_(novel)) talks about how to improve the throughput of a system. It says that the throughput of a system is limited by the slowest link in the chain, called the bottleneck. The example given in the book is about a line of boy scouts going on a trek. The pace of the line is determined by the slowest boy in the group, irrespective of his position. He is the bottleneck. The book outlines strategies to improve the throughput of the bottleneck and how this improves the throughput of the whole, relating it to a manufacturing plant.

## Building a startup
Before we can optimize the process of building a startup, we have to find out what the goal of a startup, and by extension a business, is. The goal of a business is to generate free cash flow for its owners.

The process of getting to cash flow is as follows.
![Process of getting to cash flow: cash flow, product, sales, marketing, category, market](/images/cash-flow-chain.png)

Since these steps are interdependent, we cannot change the order. The only control we have is over the throughput of every step.

## Market
The cash flow is determined most by your market. The market that you choose dictates how big you can become, how easy it will be to sell and how much fun you will have building the company. Always choose a big market or a small but exponentially growing market. Never choose a small or shrinking market, unless you want to build a lifestyle business. Choose a market where a lot of economic activity takes place, ideally where there is a lot of demand but not much supply, the characteristics of a small but fast-growing market.

## Category
After you have chosen the market, it's time to choose the category that you will be the leader in. Salesforce is in the CRM market, but it's in the category of SaaS CRMs. If it were just building another colocated CRM, it would never have become as big as it is now. You have to find a category in the market that you can dominate, preferably one with latent or present demand.

This is arguably the most important choice you will make, even more important than the market that you choose: the category of demand that you decide to serve.

## Marketing
After you have decided on a category where you will be the category leader, it's time for marketing.
Marketing determines how many people you talk to, how many people know about you and how many people want to buy from you. Improve this bottleneck by letting people know that you and your category exist, and by reaching out with outbound, advertising and other ways to reach prospective customers with demand. Its goal is to let people with demand know that you have the supply.

## Sales
Sales is how you get paid. Sales are conversations with the intent to sell. You need to ask people to pay for your product. They will be begging to pay you if you have found the demand.

For B2C demand, this is the onboarding flow of the product, and it will be much closer to the marketing demand than in B2B.

## Product
Since you have received payment, it's time to build the supply to fulfill the demand. This is where you build out the product. If the product does not satisfy the demand that was uncovered in sales, we might have to refund the cash that we collected. This is also the phase where most people start, but as we can see from the constraints, it doesn't matter what kind of product we are building. If we do not have a pipeline of demand with money to satisfy, the excess capacity of the product will always be idle, and worse, wasted.

## Cash flow
Once you have delivered the product, the cash becomes yours. That is how you improve cash flow.


As we move through each step, the amount of money that comes through it reduces. The goal is to methodically improve the bottlenecks where the most cash falls off, as you stay in business longer and longer.

Let's see how constraints and bottlenecks behave as we move through each phase of the business, with the example of building an AI-native CRM.

## Pre-startup phase
![Our AI-native CRM, pre-startup phase: only the CRM market is known at $128B; category, marketing, sales, product and cash flow are unknown](/images/cash-flow-prestartup.png)

This is the pain curve of startups, where you do not have any information about the bottlenecks and constraints of the system. We just know the total market for CRM software in the world, as published by research firms. We do not yet know the demand that we intend to serve, the category that we will dominate, how much funding that category has, how much of that demand we can reach, how much we can sell and how much product we need to build to cater to that demand.

The singular constraint to optimize in this stage is information. We need information about the demand, how much the demand is worth and how much of the demand we can serve. Most founders focus on the product here, whereas they should be focused on gathering information. As we can see, there is no information on what our constraints are. If we build a product that can serve $500M of demand, but later find out that our category only has $50M of demand, we have wasted time, money and resources optimizing something that does not affect the throughput of the system or help us move towards the goal.

The first constraint we need to optimize is finding the category that we need to build in. We talk to our founder friends, we play around with LLMs, we go to sales conferences, and we find out that there is latent demand for AI in CRMs. We find out that a lot of traditional CRM software has manual workflows that we can improve with AI, and it's only going to get better as we get more capable agents down the line. We calculate the category demand by taking the time salespeople spend doing manual work, dividing it by the total time they work, multiplying by how much money they make and halving the result to get an approximate amount of money in the category.

![Our AI-native CRM, pre-startup phase with the category chosen: CRM market $128B and AI in CRM category $11B are known; marketing, sales, product and cash flow are unknown](/images/cash-flow-category.png)

We then tap into our network, post on LinkedIn and Twitter, reach out with outbound, and come to the conclusion that as a solo founder I can generate $480K worth of marketing inbound.

Then I move on to sales, scheduling conversations with the intent to sell. I close $100K in sales with four pilot customers, as I found PULL in the market and our solution resonates with them.

While building the product, I figure out that I cannot serve two customers without engineering investment. So I figure out that the product is the bottleneck, and I raise funds to hire two engineers, who build the product to satisfy the existing demand but also produce excess capacity, bringing the product to $200K.

## Startup phase
![Our AI-native CRM, startup phase: CRM market $128B, AI in CRM category $11B, marketing reach about $480K, sales $100K (the bottleneck), product $200K ($100K sold, $100K excess capacity), cash flow $100K](/images/cash-flow-startup.png)

We have an annual cash flow of $100K. How do we improve it? We can raise more funds and invest more in engineering, but then the excess capacity will be sitting idle. We can raise funds and invest in marketing, but then we will be bottlenecked by sales. So we hire an extra salesperson and improve our sales capacity to $300K.


![Our AI-native CRM, startup phase after adding a salesperson: CRM market $128B, AI in CRM category $11B, marketing reach about $480K, sales capacity $300K ($200K delivered, $100K excess), product $200K (the bottleneck), cash flow $200K](/images/cash-flow-startup-sales.png)

We invest more in engineering, bringing its capacity to $800K, and then in sales, bringing its capacity to $500K. That is when we invest in marketing: we start writing blog posts, recording podcasts and doing PR outreach to news agencies. This brings our marketing reach to $1M. This shifts the bottleneck back to sales.

![Our AI-native CRM, startup phase after investing in marketing: CRM market $128B, AI in CRM category $11B, marketing reach $1M, sales capacity $500K (the bottleneck), product $800K ($500K sold, $300K excess capacity), cash flow $500K](/images/cash-flow-startup-marketing.png)

This is how we incrementally improve the throughput of the system: we find the bottleneck and invest in it, or improve the process so that it can keep up with demand. When the bottleneck shifts, we find the new bottleneck and improve it.

## Mid-market phase
![Our AI-native CRM, halfway to category leader: CRM market $128B, AI in CRM category $52B, marketing reach about $22B, sales $5.2B, product $5.2B, cash flow $990M](/images/cash-flow-halfway.png)

We are growing at an incredible rate and going through the cycle of improving the bottlenecks. We are emerging as the category leader.

## Category leader phase
![Our AI-native CRM, category leader: CRM market $128B, AI in CRM category $52B (the bottleneck), marketing reach $52B (all buyers in the category), sales $46.8B (90% of the category), product $46.8B, cash flow $16.4B](/images/cash-flow-leader.png)

We are the undisputed category leader in this space, reaching 90% market penetration. Now the bottleneck is the category itself, so we move on to new categories or to a bigger category. We repeat this process to dominate that market as well.

![Our company after moving to a bigger category: total sales spend market $2.4T, GTM copilots category $240.6B, marketing reach $52B (the new bottleneck), sales $46.8B, product $46.8B, cash flow $16.4B](/images/cash-flow-new-category.png)

Now we need to improve the marketing spend, change our messaging, create new campaigns and improve our messaging. We repeat the cycle again and we dominate the category.
