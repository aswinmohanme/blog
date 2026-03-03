%{
  title: "WorkBill Devlog 001",
  tags: ~w(workbill devlog),
  description: "First devlog about WorkBill, talk about why I am building WorkBill, and how I am building it.",
  draft: true
}
---

![WorkBill screenshot](../images/workbill-devlog-001/screenshot.png)

I have been working on [WorkBill](https://workbill.co) for close to three months now. So in the spirit of [Mitchell Hashimoto's Devlog](https://mitchellh.com/writing/ghostty-devlog-001), I thought it would be good to share my progress and go into the details of how I am building a new accounting platform as a solo, part-time founder.

## Introducing WorkBill 
[WorkBill](https://workbill.co) is the modern and automated double-entry accounting software for small businesses. The goal is to build a world where almost all of grunt work associated with accouting is automated, so business owners can get an stress-free, accurate and real-time view into their finances and accoutants can transistion into a more strategic role.

I have started with building out the General Ledger, which is loosely based on the flexible account model used in [BeanCount](https://github.com/beancount). You can try it out at [demo.workbill.co](https://demo.workbill.co)

## Progress
WorkBill can parse out bank transactions from PDF and CSV statements, create journal entries, create a chart of accounts and see the Income Statement and the Balance Sheet of the business. I have a private limited setup in India, and I use WorkBill to bookeep the small number of transactions going through it.

## TechStack
Since I am the only person working on this, I wanted the techstack to be simple, keeping engineering to a minimum, while not comprimising on the user-experience.

### Backend, Elixir and Phoenix
I am an Elixir developer by heart, and use it at my full-time job. So naturally I decided to build WorkBill with Elixir and Phoenix. It's fast, robust, has great primitives for realtime, constantly improving and has a small but complete package ecosystem. The testing story is great too. Even though I am not an ardent follower of test driven development most of the critical ledger code is covered under tests. The test are easy to write and finish fast.

I use ExMoney to represent money, Oban for background jobs and processing, Baml and the excellent BamlElixir library for calling LLMs for reconcilation.

### Postgres
The Ledger is based on relational data model and Postgres is the one which already comes with Phoenix. I will worry about database requirement once I hit the scale where it's supposed to hurt. For now, trusty Postgres it is.

### Frontend, Inertia JS, React
I was never a fan of GraphQL, leaving me with building out an API based backend or a LiveView based app. I didn't consider LiveView because even though it had excellent developer experience, the user experience always felt off. Also I couldn't use any of the great frontend libraries that were for react, especially ShadCN.

I had built an mvp for an email client using TanStack Router and a Phoenix Api, but it was a bit cubersome to work with. I had to wire up auth, then create the endpoint, use React Query to fetch the data on the frontend, navigate on frontend. Everything was complicated. I then found out InertiaJS.

InertiaJS is a glue framework where your write your controllers in the same way you build a MVC app, and instead of serving static html, we serve react pages with the data already passed as props. This helps us skip over frontend auth, data fetching, catching and use backen redirection, Plugs for auth protection and all. This meant I could just write the controllers however I wanted to and let and use any forntend frameworks I want and inerita will take care of the rest. It has been a really great framework, the productivity is unmatched, the UX is great, and even though some features like modals require a couple workaround, everything else is great. The entirety of the platform is built using InertiaJS.

### AI tools
I use Reducto to parse the bank statements, and BAML to extract structured output from a lot of different providers.

### Tech which didn't made the cut

## Flexible Ledger

## Automated Reconcilation
