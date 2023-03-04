%{
  title: "ChatGPT and Prompt Based Development",
  tags: ~w(chatgpt ai),
  description: "Since the release of ChatGPT API, there are multiple apps that have up. Unlike other software platforms the core difference here are the prompts. In this post I explore how this changes Software Development.",
}
---

I was scrolling through my Twitter feed when I came across this [tweet](https://twitter.com/thetronjohnson/status/1631513838486163458) about a travel planner built on top of the recently released ChatGPT API.

![Tweet from Kiran](../images/roamaround-tweet.png)

I checked out [RoamAround](https://roamaround.io) and it's a fairly simple travel itinerary planner. When you provide the place, date of travel, and duration of stay, it returns an itinerary. The quality of the itinerary varies from okayish to good.

![Roam Around Website](../images/roamaround-site.png)

Around six months ago, I had the billion-dollar idea of building a travel itinerary planner (who doesn't?) with one of my friends. We wanted to build a similar platform that would also be integrated with airlines and hotels for affiliate money. After digging in, I realized how hard and useless building a travel planner would be as a business. I would have to collect a lot of information about many places and arrange them hierarchically based on location and proximity. It would require a tremendous amount of manual intervention or high-quality automation tools to be implemented. We would also have to ensure that a vast array of queries resolve quickly to not bore our customers. It was a massive technical hurdle for a single person to ever cross.

Contrast that with how our Roam Around website would have been built. The creator would have tried some prompts with placeholder values in ChatGPT. Once they fine-tuned a prompt that would give satisfactory results, they moved on to building the frontend. The frontend is a literal form that substitutes the values in the prompt and sends the prompt to ChatGPT API. ChatGPT executes the prompt like a virtual machine and returns the results that are displayed as is. The entire product process might not have taken more than a day.

The most crucial part of the process was optimizing the prompt, i.e., **Prompt Engineering**. The current trends reflect that too. My Twitter feed is filled with people writing and sharing ChatGPT and DALL-E prompts. We even have websites to share prompts that circumvent the "safeguards" put in place inside these models. With sufficiently complex models, any business use case can be reduced to a creative prompt.

With our AI models rapidly converging towards Artificial General Intelligence, the most useful skill in the new world would be the creation and manipulation of prompts. The future of software development will be business persons coding up their own business logic using prompts and a thin wrapper around that to accept user input. And when that day comes, we will be working on AIs to make the process of writing prompts easier.
