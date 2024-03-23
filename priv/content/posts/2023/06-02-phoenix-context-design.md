%{
  title: "An Opinionated Guide to Organizing your Elixir Code with Phoenix Contexts",
  tags: ~w(phoenix contexts design),
  description: "A set of guidelines, tips and tricks that I have used to organize small to medium size Elixir Phoenix projects using Contexts.",
  rating: 2,
  draft: true
}
---

![Organized Things](/images/organized-things.jpeg)

Organizing code with contexts is hard, especially when you are starting out. This blog post outlines the guidelines that I follow when creating new Phoenix apps to create contexts that make sense, are maintainable and easy to change in the future.

Let's start with why we need contexts.

## Why we need contexts
We need contexts because your application might require to be accessed through different frontends and because your application will change in the future.

### Phoenix is not your application
Contexts exist to decouple your internal business logic from the external means of delivery. 

Consider that your business logic exists inside your LiveView, where you directly interact with the database through Ecto and manipulate the schemas as you please. If you later decide to expand to hardware and use Nerves, you'd have to either duplicate the logic or extract it out. Contexts help you to extract out the business logic to modules that are independent of the method of delivery. Contexts and Schemas form the core of your application that can be accessed through LiveView, a JSON Api or a Nerves frontend. Contexts are a first degree of separation between your data layer and your presentation layer acting as your boundary.

### Your application can and will change
Your application changes and evolves with time, and your codebase needs to support the changes as well. Contexts encapsulate the changes so it can be changed only once. Having a codebase that mirrors your business rules would keep the complexity in check.

## Rules for Contexts
These are the guidelines that I keep in mind when I am working on my Elixir and Phoenix apps. True to the words these are just guidelines so keep that in mind when you are working with this. It's up to you to know when to use this and when to not use this. But in my case 90% of my usecases have been covered by these that I do not deviate often.

### Start with the Data Layer
Each Schema should be it's own Model. This is the lowest layer of the application. This is the layer of the changeset. This is the layer where you directly manipualate the changeset, setup validations and setup other changesets. The only exception to these are manipulating associations as a whole which can be managed in the Secondary Context of the primary context.

Start with modelling the data layer of the application. Every application is in it's.

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
