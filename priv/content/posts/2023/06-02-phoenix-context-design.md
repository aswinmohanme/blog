%{
  title: "An Opinionated Guide to Organizing your Elixir Code with Phoenix Contexts",
  tags: ~w(phoenix contexts design),
  description: "A set of guidelines, tips and tricks that I have used to organize small to medium size Elixir Phoenix projects using Contexts.",
  rating: 2,
  draft: true
}
---

When I was starting to learn Phoenix the most trouble I had was how to organize the code with Contexts. It also didn't help the generators make heavy use of Contexts, which meant you needed a thorough enough understanding to even get started. This blog posts outlines the guidelines that I follow with Phoenix Contexts. Keep in mind that this is a personal opinionated guide and used in small to medium projects that I work on. I am writing this hoping this might help you get unstuck with Contexts.

First let's see why we need Contexts.

## Phoenix is not your Application
The reason why Contexts exists and is recommended instead of directly accessing the Ecto Schemas in the Controllers and LiveView is because Phoenix is Boundary that exists to deliver the business logic in your Core to your customers. Contexts exist to decouple your internal business logic from the external means of delivery. Let's say that your business logic is not decoupled and exists inside your Controllers, where you directly call Ecto and 


### References
 - [A Proposal for Some New Rules for Phoenix Contexts](https://devonestes.com/a-proposal-for-context-rules)
