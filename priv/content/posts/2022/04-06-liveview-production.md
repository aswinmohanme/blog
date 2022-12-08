%{
  title: "Phoenix LiveView in Production",
  tags: ~w(liveview phoenix flyio),
  description: "I used Phoenix LiveView in Production for my last startup IndiePaper. This blog post outlines why I used LiveView, issues I came across, the good parts and gotchas to look out for."
}
---

I came across a [thread on
ElixirForum](https://elixirforum.com/t/are-you-all-in-on-liveview-how-are-you-using-it/41628/14)
that highlighted how everyone was using LiveView in their production
apps. Since IndiePaper is a Phoenix LiveView app, I thought it would be
nice to share my experience with it.

## Context

Before we jump right in, it\'s better to have some context about me and
about the project. I\'m a single developer working on IndiePaper. It is
a book publishing platform, where authors can write out their book in an
online text editor and we typeset beautiful PDF books from it. The app
is a simple CRUD app with auth, uploads and a custom typesetting engine.

I used TDD to develop the app and it\'s deployed on
[fly.io](https://fly.io).

## Why chose LiveView?

I wrote the first version of IndiePaper in Phoenix, but it was at a time
when I didn\'t know anything about the framework. I rewrote the entire
app in NextJS and Hasura, then in Rails, then using FaunaDB, then in
LiveView and finally in in vanilla Phoenix. This time around I knew
enough Elixir and Phoenix to actually make something useful. I was
content with the full page reloads and it was working well.

After some features was complete I wanted to add file uploads for book
promo images. Even though there were well built packages for handling
uploads, I was intrigued by the [File Uploads in
LiveView](https://www.youtube.com/watch?v=PffpT2eslH8) video by Chris. I
tried implementing it, but it didn\'t work out because I didn\'t know
anything about LiveView. So I bought [Programming Phoenix
LiveView](http://pragprog.com/titles/liveview/programming-phoenix-liveview/)
and [Testing LiveView](https://www.testingliveview.com/) and started
learning about it.

After a while I finished setting up the uploads feature. Then I
converted one more page just for the sake of it and was instantly
hooked. I ended up converting the entire app to Phoenix LiveView,
including a complex realtime editor. LiveView wasn\'t chosen, I used it,
loved it and used it again.

## The Great Parts

For any tech to be adopted widely, it should be exponentially better
than it\'s predecessors and current competition (except if you\'re
javascript). Phoenix LiveView is a step up from everything that has come
until now, with great just enough abstractions and great developer
experience.

### Elixir Phoenix

Elixir and Phoenix is the best part about LiveView. Elixir is a recent
language and hence do not have the hairy legacy that older languages. It
has beautiful patterns, beautiful constructs and beautiful tools that
make working with it a beautiful experience. Phoenix as a framework is
highly performant even with small system configurations, and that sub
10ms response time is a major factor why LiveView has a usable
experience.

### Testing

The second best thing I loved about LiveView is testing, especially
integration testing. I used to write integration tests with Wallaby
which ran the tests in a headless browser. This lead to slow and flaky
tests, even with parallel tests and error recovery. LiveView runs tests
without instantiating a browser. It handles clicks, redirects, and form
events. This leads to fast and stable tests.

### SPA without SPA

This is the major selling point of LiveView and it holds that promise
well. Single Page Apps with a REST or GraphQL backend requires a lot of
extra code at the middle where the communication happens. With LiveView
your app acts with almost the same performance and UX of a well built
SPA without the need for API interfaces. You specify the data in the
templates and it does the rest.

### Javascript Hooks

Interop with Javascript is done through hooks. They enable you to
\"hook\" into various lifecycle events of the LiveView process. Unlike
other frameworks where escape hatches are an afterthought, hooks are
well designed. For IndiePaper I made a text editor using TipTap and was
able to convert the entire page from Vue to hooks with the hooks version
being more capable and better.

### Performance

With the new `live_session` helper, we can bundle together liveviews and
the navigation happens through the same websocket. This is insanely
fast. Page navigations happen in under 100ms using from India with the
server in US.

## The Good Parts

These are the things that I liked and would never give up, even though
these were not the reason I would switch to LiveView.

### Form Recovery

Phoenix LiveView requires internet connection to function. But sometimes
internet gets disconnected. This can be frusturating when the person is
filling a form, because on reconnection Phoenix restores the last known
data. If you have a `handle_event` setup with your LiveView, the form
state gets automatically synced with the server.

### Free Websocket

You get a full functional bi-driectional websocket with good
abstractions for free. For the realtime text editor, rather than
implementing a complex system wiht Redis and syncing, I created a json
diff and sent the data through the websocket with `pushEvent` function.

## The Bad Parts

Every technical choice has it\'s downsides, and LiveView is no
exception.

### Requires Internet Connection

LiveView requires an active internet connection to work properly. This
might not be an issue for 90% of people, but if you\'re domain requires
offline access, LiveView might not be a good fit. This might be a
temporary problem as work is being done to add more offline capabilities
to LiveView.

### Almost Maturing Ecosystem

I hate to put this as a negative, but as LiveView is a young framework,
it has not many resources to learn from for beginners. Although the
community is small, it\'s really active and welcoming, so this won\'t be
a problem for long.

## The Fuck This Parts

Gladly nothing yet. I love Phoenix LiveView, in almost 5 months with
LiveView I have never come across a scenario where I just put my hands
up and thought about switching to another framework.

## The Hopeful Parts

Things I wish the LiveView ecosystem would have, but doesn\'t or
shouldn\'t.

### Mobile

It would be nice to have a way to run LiveView as a native app on
mobile. I recently made a React Native app with a Phoenix backend and I
was put off by the amount of middleware code I had to write to get the
data and display it. It would be great if we could write a LiveView app
that updated a React Native based mobile app.

This might sound like a hype post for LiveView, and it would be
partially true. I loved using Phoenix LiveView for IndiePaper and If I
had to start over again I would choose it again. It has it\'s
shortcomings, sure, but it has the least shortcomings of any framework I
have used. Try it out, you might surprise yourself.
