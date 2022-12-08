%{
  title: "Superfast Webapps using NextJS, Vercel, LiveView and Fly.io",
  rating: 2,
  tags: ~w(elixir phoenix nextjs flyio),
  description: "IndiePaper has a NextJS frontend which proxies requests to the LiveView backend. This means that I can easily edit and serve the marketing pages separtely and make it available even when the main site goes down. This post outlines the setup."
}
---

Making fast web apps is hard but a tremendous [business oppurtunity](https://www.businesswire.com/news/home/20180724005488/en/Slow-Websites-Are-Silent-Killers-for-Businesses). It's also the right thing to do. In this blog post, I'll explain how [IndiePaper](https://indiepaper.me) achieves decent performance with NextJS, and Phoenix hosted on Vercel and Fly.io respectively. Big thanks to Plausible.io for pointing out the [way](https://github.com/plausible/analytics/discussions/1593).

Making a fast web app is complex, It requires tuning a lot of moving parts. The technology that you chose has a measurable impact on performance. We chose these technologies because they optimize for and care about performance.

### NextJS

It's a framework based on React, geared towards static and dynamic web apps. It has a lot of sane defaults and can get you a halfway decent SPA experience out of the box. It has a couple of features like optimized images, preloading routes, chunked downloads and dead code elimination that makes the user experience insanely fast.

### Vercel

They are the company behind NextJS, providing great support for hosting and distributing NextJS apps. They deploy your static site via their global CDN close to your users. With NextJS and Vercel people can see sub 50ms response times for your website.

### Phoenix LiveView

Phoenix is the premier web framework for Elixir. It's fast, with microsecond response times, has an intuitive programming model and is the best fit for making dynamic server-side apps. LiveView takes this up one notch by making the data transfer over a persistent WebSocket connection which gives an SPA like experience.

### Fly.io

Hosting static sites closer to people using CDNs is kind of easy. But doing the same for dynamic server-side web apps is still a hard problem. Fly.io streamlines running your apps close to people. It supports databases, work well with Phoenix, has library support for global databases and is comparatively cheap. Phoenix LiveView on Fly.io is a killer combination, and with enough regions, it's indistinguishable from a Single Page App.

Separating Static and Dynamic
-----------------------------

I implemented this setup, not because of the obvious performance benefits, but because I wanted to separate static pages like the home page, privacy policy and dynamic content from the dynamic author dashboard. Initially, all pages including the homepage were served from the Phoenix app itself. This meant waste of server resources, pages couldn't be reliably cached, and every small grammatical change polluted the main application repo and needed a server restart.

I was fine with this until I wanted a blog, and that too as a subdirectory for SEO reasons. That's when I decided to move the static pages to a NextJS app that can be statically generated and serve the remaining pages from the Phoenix app. That way we get the speed of static sites, and the interactivity of Phoenix LiveView.

Domain Setup
------------

1.  Point Domain Nameservers to Vercel (optional) This makes sure that all requests directly pass to Vercel, which improves performance.
2.  Deploy NextJS app to Root Domain on Vercel Use the root domain `https://yourdomain.com` for deployment, and make sure to redirect `www.yourdomain.com` to it.
3.  Deploy Phoenix LiveView to app subdomain on Fly.io Use fly.io and deploy the LiveView app to subdomain \`app.yourdomain.com\`. Point the subdomain to the fly.io IP address and generate a certificate. Make sure to set the `PHX_HOST` variable as the root domain `https://yourdomain.com`.

Using Vercel as a Reverse Proxy
-------------------------------

We want all our requests to first go to Vercel and need Vercel to forward all requests it cannot fulfil to our LiveView app. NextJS has a handy feature called [Rewrite Fallback](https://nextjs.org/docs/migrating/incremental-adoption#rewrites), that enable us to do just that.

When a request hits our NextJS app it checks if the NextJS app has that route. If it has, then it fulfils that request. If there is no corresponding route, rather than showing a 404 page, Vercel then proxies the requests to our LiveView app hosted on our `app` subdomain, without changing the URL. Put this config in `next.config.js`.


```elixir
module.exports = {
  async rewrites() {
    return {
      // After checking all Next.js pages (including dynamic routes)
      // and static files we proxy any other requests
      fallback: [
        {
          source: '/:path*',
          destination: `https://app.example.com/:path*`,
        },
      ],
    }
  }
}
```
        

Websockets and Cookies
----------------------

If you were using vanilla Phoenix apps, this was only necessary. But since we are using LiveView we need some additional setup.

### Websockets

By default the LiveView WebSocket will be started in `wss://yourdomain.com/live`. But Vercel does not support proxying WebSockets. We need to directly connect to our app running on the \`app\` subdomain. Put this in your `app.js` file in LiveView. This sets the WebSocket connection on `app` when deployed and localhost when running locally.

```elixir
const host = window.location.host;
let liveHost = "";

if (host === "yourdomain.com") {
  liveHost = "wss://app.yourdomain.com";
}

const socketHost = `${liveHost}/live`

let liveSocket = new LiveSocket(socketHost, Socket, {
...
}
```
        

### Cookies

Phoenix stores session information in cookies, which are sent along with every response. Since we are using the same domain as defined by `PHX_HOST`, cookies are sent correctly with the HTTP request. But cookies are not sent with the Websocket connection because we are hosting it on the `app` subdomain. By default, cookies are not shared between subdomains. Configure cookies to be shared across subdomains on your `endpoint.ex` file.

```
@session_options [
...
domain: ".yourdomain.com"
]

socket "/live", Phoenix.LiveView.Socket, websocket: [connect_info: [session: @session_options]]
```

Remember to put the dot. It makes sure the cookies with your session information is shared.

### Check Origin

In `runtime.exs` file be sure to add both your domains so your requests are not rejected.

```
config :your_app, YourAppWeb.Endpoint,
    url: [host: host, port: 443],
    check_origin: [
        "https://#{host}",
        "https://app.#{host}"
    ],
```

Results
-------

IndiePaper follows this architecture. You can check it out at [https://indiepaper.me](https://indiepaper.me)

The root domain points to a configured [https://github.com/timlrx/tailwind-nextjs-starter-blog](https://github.com/timlrx/tailwind-nextjs-starter-blog) blog hosted on Vercel. It handles all the traffic from around the world and serves the blog on [https://indiepaper.me/blog](https://indiepaper.me/blog). I can edit blog posts add and remove pages, all without touching the main phoenix app.

Once the author signs up, the author is taken to [https://indiepaper.me/dashboard](https://indiepaper.me/dashboard). It is hosted on `app.indiepaper.me` proxied through Vercel. Once the author reaches the backend, LiveView takes over. No further HTTP requests are made as the navigation takes place through [live\_session](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.Router.html#live_session/3). The WebSocket directly connects to Fly.io without going through Vercel making the app navigation smooth and fast.

Seperating out your Static and Dynamic content is neccesary for SEO and marketing reasons. Splitting and hosting your app this way enables you to have a great user experience while having minimal impact on your developer experience. Suggestions are always welcome.
