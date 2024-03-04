%{
  title: "Treat URLS as your Friend",
  tags: ~w(web),
  description: "URLs are flexible and can be modelled for improving the UX of your app."
}
---

> Store your important public state that defines the flow of where your users are in the URL, and treat it as the single source of truth. Rather than starting from a blank state on page load, parse the URL and extract the params required, and restore the state from it. Even when the browser reconnects or refreshes the user flow will never be interrupted and can pick up from you left off.

Storing a state on an ephemeral platform such as the Web, where a refresh can wipe the said state from memory is a problem. Having the state reset in the middle of an action creates a memorable user experience, but not in a good way. Think of all the times a modal closed by itself when your internet reconnected. You can store the state locally and use the in-memory store as a cache, but that brings extra complexity and its own class of hairy problems. If only there was a place where we could store our state and have it persist after refreshes and reconnects, while still being easily accessible and easily manipulated. Turns out there is one, and it's staring right at you and the people using your app.

## Reintroducing the URL

The Web at its core is a collection of URLs. You have the URL, you go to the website, go back change the URL, go forward, change the URL, refresh, the URL stays the same. The URL is the single source of truth for your web browser, and that makes it an excellent place to store our public flow state. It's easily parseable and easily manipulated, well defined and most environments already have primitives that enable its manipulation easily.

Store your important public state that defines the flow of where your users are in the URL, and treat it as the single source of truth. Rather than starting from a blank state on page load, parse the URL and extract the params required, and restore the state from it. Even when the browser reconnects or refreshes the user flow will never be interrupted and can pick up from you left off.

An example of a great implementation of this pattern is Phoenix LiveView. Phoenix is a web framework written in Elixir, LiveView being an extension of the framework to build SPA like experiences without Javascript. We can store the internal state in LiveView and use that to track whether a modal is closed or open. But rather than relying on the internal state, LiveView has a pattern of updating the URL, which triggers a listener to update the state of the internal LiveView. That way even if the backend server crashes or the website reconnects, the flow is never disrupted.

There are some downsides though.

- Only store the minimum state for restoring the user flow in the URL. URLs have a soft limit of 2048 characters[0]. Long URLs cause a host of issues that might be hard to track down.
- URLs are defacto public, only store non-sensitive states.

Next time when you're building something, think of the state that might cause disruptions on the user flow when refreshed, and model that state in the URL, keeping the URL as the single source of truth.

[0] - https://stackoverflow.com/questions/417142/what-is-the-maximum-length-of-a-url-in-different-browsers
