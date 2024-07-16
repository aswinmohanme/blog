%{
  title: "Smart Servers, Dumb Clients",
  tags: ~w(web-development code),
  description: "I keep most of the logic of the apps I build on a monolothic server, this post explains why.",
  draft: true
}

---

On all the projects that I work on, the best developer and user-experience has been on the ones where most of the logic lived on the server and the clients acted as dumb rendering frameworks which took the data flowing from the server and rendering a UI out of it. The opposite was also true. Projects where majority of logic lived on the clients were hard to maintain and develop new features for. 

The easy explanation for this is reducing duplication. If the same logic needs to be run on your mobile and your web app it makes sense to lift it up to common parent so it can be shared.

The other reason is to ensure that data is validated correctly at the boundary of the application. I have seen apps with complex validations on the client side that responds instatneously to user-feedback. But these validations could be easily side-stepped by calling API directly.

The reason I love this pattern so much is because of technical choices I could make. Elixir is the language that I like to work on now, but I can't use it to build out apps that feel native, for that I use React and React Native. I write my validations, authorization checks in Elixir and use React and React Native to render out the data and errors out to a UI for the user to interact with. This tech stack enables me to spend most of my time in Elixir, while making sure the experience of my users never go down.
