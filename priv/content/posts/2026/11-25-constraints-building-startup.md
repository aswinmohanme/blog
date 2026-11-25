%{
  title: "Theory of constraints and building a startup",
  tags: ~w(startup),
  description: "How to apply the theory of constraints to build a startup and where to focus on first. Tldr: Sell first before building.",
  draft: true
}

---

The theory of constraints from the book [The Goal](https://en.wikipedia.org/wiki/The_Goal_(novel)) talks about how to improve the throughput of a system. It's says that the throughput of a system is limited by slowest link in the chain, called the bottleneck. The example given in the book is a about a line of boy scouts going for a trek. The pace of the line is determined by the slowest boy in the group, irrespective of his position. He is the bottleneck. The book outlines the strategies to improve the throughput of the bottleneck and how this helps to improve the throughput of the whole, relating to a manufacturing plant.

## Building a startup
Before we can optimize the process of building a startup, we have to find, what is the goal of a startup and by it's extension a business. The goal of a business is to generate free cash flow for it's owners.

The process of getting to cash flow is as follows.
![Process of getting to cash flow: cash flow, product, sales, marketing, category, market](/images/cash-flow-chain.png)

Since these steps are interdependent on each other, we cannot change the order. The only control we have is over the througput of every step. The best thing about building software is that the product will never be bottlenecked, we can scale to n demand easily and without constraints. This means what we need to optimize is on the right side of product.

## Market
The cash flow is determined most by your market. The market that you chose dictactes how big you can become, how easy it would be to sell and how much fun you will have building the company. Always choose a big market or a small but exponentially growing market. Never choose a small or shrinking market, unless you want to build a lifestyle business. Choose a market where a lot of economic activity takes place, ideally where there is a lot of demand, but not much supply, the characteristics of a small but fast growing market.

## Category
After you have chosen the market, now it's time to choose the category that you will be the leader in. Salesforce is in the CRM market, but it's in the category of SaaS CRMs, if it was just building another coloacted CRM it would never have been as big as it is now. You have to find a category in the market where you can dominate. Find a category with preferably latent demand or present demand.

This is argubly the most improtant choice you will take, with more importance that the market that you choose. The category of demand that you have decided to serve.

## Marketing
After you have decided a category where you will be the category leader, it's time for marketing.
Marketing determines how many people you talk to, how many people know about you and how many people want to buy from you. Improve this bottleneck by letting people know you and your category exists and reaching out with outbound, advertising and other way to reach your prospective customers with demand. It's goal is to let people with demand know that you have a supply.

## Sales
Sales is how you get paid. Sales are conversations with intent to sell. You need to ask people to pay for your product. They will be begging you to pay if you have found out the demand.

For B2C demand this is the onboarding flow of the product, and will be much more closer to the marketing demand than B2B.

## Product
Since you have recieved payment, it's time to build the supply to fulfill the demand. This is where you build out the product. If the product does not satisfy the demand that was uncovered in sales, we might have to refund the cash that we collected. This is also the phase where most people start, but as we can see from the constraints, it doesn't matter what kind of product we are building, if we do not have a pipelines of demand with money to satisfy the excess capacity of building the product will always be idle and more than that a waste.

## Cash flow
Once you have delivered the product, the cash becomes yours. That is how you improve cashflow.


As each step follows through the amount of money that comes through each step reduces. The goal is to methodologically improve the bottlenecks, where the most amount of cash falloff happens as you stay more and more in business.

Let's see how constraints and bottlenecks behave as we move through each phase of the business, with the example of building an AI-native CRM.

## Pre startup phase
![Our AI-native CRM, pre-startup phase: only the CRM market is known at $128B; category, marketing, sales, product and cash flow are unknown](/images/cash-flow-prestartup.png)

This is the pain curve of startups, where you do not have any information about the bottlenecks and constraints of the system. We just know the total market of CRM software in the world, published by research firms. We do not yet know the demand that we intend to serve, the category that we will dominate, how much that category has funding in,  how much of that demand we can reach, how much we can sell to and how much product we need to build to cater to that demand. 

The singular constraint to optimize in this stage is information. We need information about the demand, how much the demand is worth and how much of the demand we can serve. Most founders focus on product here, whereas they should be focused on gathering information. As we can see there is no information on what our constraints are. If we build a product that can serve $500M of demand, but we later find out that our category only has $50M of demand, we have wasted time, money and resources optimizing something that does not affect the throughput of the system or help us move towards the goal.

The first constraint we need to optmize is to find out the category that we need to build in. We talk to our founder friends, we play around with LLMs and we go to sales conferences and we find out that there is a latent demand of AI in CRMs. We find out a lot of traditional CRM software has a lot of manual workflows that we can improve with AI and it's only going to improve as we get more capable agents down the line. We calculate the category demand as the amount of time sales persons spend doing manual work and divide it by time they work and how much money they make and divide it by half to get an approximate amount of money in the category.

![Our AI-native CRM, pre-startup phase with the category chosen: CRM market $128B and AI in CRM category $11B are known; marketing, sales, product and cash flow are unknown](/images/cash-flow-category.png)

## Startup phase
![Our AI-native CRM, startup phase: CRM market $128B, AI in CRM category $11B, marketing about $480K, sales $100K, product $50K, cash flow $50K](/images/cash-flow-startup.png)

In the startup phase, you have chosen to build an AI-native CRM in the CRM market. The market and category are two places where you do not have control to improve, you can only change it. Now it's upto us to 

## Mid-market phase
![Our AI-native CRM, halfway to category leader: CRM market $128B, AI in CRM category $52B, marketing about $22B, sales $5.2B, product $5.2B, cash flow $990M](/images/cash-flow-halfway.png)

## Category leader phase
![Our AI-native CRM, category leader: CRM market $128B, AI in CRM category $52B, marketing about $23B, sales $10.8B, product $10.8B, cash flow $3.7B](/images/cash-flow-leader.png)
