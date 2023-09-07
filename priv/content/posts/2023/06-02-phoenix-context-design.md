%{
  title: "An Opinionated Guide to Organizing your Elixir Code with Phoenix Contexts",
  tags: ~w(phoenix contexts design),
  description: "A set of guidelines, tips and tricks that I have used to organize small to medium size Elixir Phoenix projects using Contexts.",
  rating: 2,
  draft: true
}
---

When I was starting to learn Phoenix the most trouble I had was how to organize the code with Contexts. It also didn't help the generators make heavy use of Contexts, which meant you needed a thorough enough understanding to even get started. This blog posts outlines the guidelines that I follow with Phoenix Contexts. Keep in mind that this is a personal opinionated guide and used in small to medium projects that I work on. It's a combination of rules from the Devon Estes blog post and the Designing Elixir Apps with OTP book. If you want a deeper dive, the book is highly recommended.

First let's see why we need Contexts.

## Phoenix is not your Application
The reason why Contexts exists and is recommended instead of directly accessing the Ecto Schemas in the Controllers and LiveView is because Phoenix is Boundary that exists to deliver the business logic in your Core to your customers. Contexts exist to decouple your internal business logic from the external means of delivery. 

Let's say that your business logic is not decoupled and exists inside your LiveView, where you directly call Ecto and manipulate the schemas as you please. Due to the success of your webapp you are asked to build out a nerves based hardware as well. Turns out you are writing the same code twice. It would have been great if you had the Core of youre. This is our first point. Phoenix is not your application. You should have a core that is independent of the delivery mechanism. It shouldn't matter whether it's a JSON api or Web based API, or LiveView. That is where the need for contexts arise. It's a first degree of separation between your data layer and your presentation layer acting as your boundary.

Since we have established why we need contexts, let's see some rules to organising your code with contexts.

## Rules for Contexts
These are the guidelines that I keep in mind when I am working on my Elixir and Phoenix apps. True to the words these are just guidelines so keep that in mind when you are working with this. It's up to you to know when to use this and when to not use this. But in my case 90% of my usecases have been covered by these that I do not deviate far from this.


### Everything starts with the Data Layer
Each Schema should be it's own Model. This is the lowest layer of the application. This is the layer of the changeset. This is the layer where you directly manipualate the changeset, setup validations and setup other changesets. The only exception to these are manipulating associations as a whole which can be managed in the Secondary Context of the primary context.

### Secondary Context
Every Primary Context has an associated Secondary Context. It is mostly named as the plural of the Primary context. It's primary role is to contain the lower order functions of the Primary Context. This means everyting from listing, to creation, to updation of the individual context is done here. It should be moslty top layer if it is used by multiple contexts, but as a sub context if it is only part of one primary context.

### Associations
Now let's get into the meaty part. Where to keep associations. Let's say that we have a user and an associated profile. Where should we store the list of objects as well. First create the `MyApp.Users` and `MyApp.Users.User` contexts. Then create `MyApp.Users.Profiles` and `MyApp.Users.Profiles.Profile` context. Since profile will only belong to Users as of now. Now you can add the functions that manipulate Users in `Users` and `Profiles` respectively.

What about the `get_profile_of_user(user)` function. Now that is tricky. Does it belong in the Users or Profiles functioh. The function should belong to the context which manipulates the schema. Since this function returns the `profile` it should go in the `Profiles` context. But then it violates the other rule that you cannot have two Secondary Contexts calling around schemas. So rewrite the function as `get_profile_of_user(user_id)`. Only pass ids or the primary struct of in the Secondary Context.

### Teritiary Contexts
Now let's bring up teritiary contexts. Sometimes you to code functions that need to touch two contexts. That's when we use Teritiary contexts. Use `UserPitches` to house functions that affect both the user and pitches together. That is where you can house the `list_pitches(user)` where user the user struct. You are only allowed to contact functions from secondary contexts from here.

### Higher Order Business Functions
What about higher order business functions. Now these are functions that achieve a lot and touch a lot of different contexts. To organise them I create Jobs to be done contexts. Let's say that I have an order that needs to be fulfilled. I create a `CreateOrderJob` context. The context will only have one function, `run/1` that needs all the information that is required. If the data comes from a form that needs to be backed up by the struct, you can use the `embed_struct` directive as well.

- Use `run` function to run the fucntion
- Use `changeset` to write the changeset as well.

### References
 - [A Proposal for Some New Rules for Phoenix Contexts](https://devonestes.com/a-proposal-for-context-rules)
 - [Designing Phoenix Applications]()
