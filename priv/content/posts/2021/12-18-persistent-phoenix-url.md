%{
  title: "SEO Friendly Persistent URL Slugs in Elixir Phoenix",
  tags: ~w(elixir phoenix web),
  description: "Learn how to implement seo slugs in Elixir Phoenix"
}
---

When building out a platform it's a great idea to let your primary outside world resource be reachable via slugs in the URL. Take the case of [IndiePaper](https://indiepaper.me), the main resource is books, rather than letting Authors share a link with the default id https://indiepaper.me/books/06c9fa8f-19b3-4fa1-bcb7-24a2ee2e42f7, it's best to have them share a URL with the Title in it https://indiepaper.me/books/indiepaper-building-the-future-of-publishing. This is better for SEO and readabilty.

Let's say the Authors shares this link on their Social Media and blog posts. Months down the line the Author want to change the title to something else, but changing the title would change the URL and that would render all the traffic coming from the old links hit 404. We need URLs to point to the same resource, even if the slug changes and we're going to learn to implement that in Elixir Phoenix.

## Phoenix Params

Let's say you have an project where Authors can post Books for sale. You will have a `Book` schema, and a `Books` context. You have the `/books/:id` route setup to go to the `show` action in your `BookController`.

When you want to link to a show page, you use the `Routes` helper.

```
<%= link to: Routes.book_path(@conn, :show, book) %>
```

But how does it resolve the entire book to a single id ? Enter [Phoenix Params](https://hexdocs.pm/phoenix/Phoenix.Param.html). Phoenix Params is a protocol to convert data structures to params usable in URLs. When used with Schemas the default `:id` parameter is used. To use a slug with our URLs we have to implement our own custom behaviour using this protocol, so when given a `book` rather than extracting `:id`, it will extract our `:titled_slug`.

Add this behaviour that implements the protocol to end of `books/book.ex` file, and add the `to_slug/2` function to `Book`. Be sure to add [Slugify](https://hexdocs.pm/slugify/Slug.html) your mix.exs file ` {:slugify, "~> 1.3"}`, so you can use `Slug.slugify/1`.

```
def YourApp.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset

  ...

  def to_slug(id, title) do
    "#{Slug.slugify(title)}-#{id}"
  end
end

defimpl Phoenix.Param, for: IndiePaper.Books.Book do
  def to_param(%{id: id, title: title}) do
    IndiePaper.Books.Book.to_slug(id, title)
  end
end
```

What this does is that the next time you call `Routes.book_path(@conn, :show, book)`, it produces `/book/title-slugified-UUID-ID-OF-BOOK` instead of `book/UUID-ID-OF-BOOK`. Since UUID's have a consistent length we can add them at the end, so the title is more prominent in the URL. If you're using Integer ID's there's a section in the bottom for that.

One half of the job is done, we can now generate the slug from the schema. Now let's see how to use that in our URLs.

Open up your `router.ex` file and where you are defining your book routes, define the param as slug. This is done so you can easily parse out the `slug` from the url.

```
# If you're using Vanilla Phoenix
resources "/books", BookController, only: [:show], param: "slug"

# If you're using LiveView
live "/books/:slug/", BookLive, :show
```

In your `show` action in your `BookController`, you can get the slug from the params.

```
def show(conn, %{"slug" => book_slug} = _params) do
    book = Books.get_book_from_slug!(book_slug)
    ...
end
```

Now we have to implement the function in `Books` Context which will parse out the `:id` from the `slug` and return the book. Open `books.ex` and insert this.

```
def get_book!(book_id), do: Repo.get!(Book, book_id)

def get_book_from_slug!(slug) do
    id = String.slice(slug, -36, 36)
    get_book!(id)
end
```

Since we know the `id` is going to be 36 characters long, we parse it out from the back of the String using the `String.slice` method. We get the id and pass it into `get_book!` which is a standard context function to get the book.

Since we discard the title from the slug and only query using the `id`, we can be sure that even if the title is changed the old and the new URLs still point to the same book. That is how folks we implement persistent Slugified URLs in Elixir Phoenix.

### Using Integer IDs

If you're using the default auto-increment ids, we have to do some minor changes. Since the length of auto-increment ids can change, we cannot append them to the back but only to the front. This affects the slug creation and parsing step only.

```
def to_slug(id, title) do
    "#{id}-#{Slug.slugify(title)}"
end
```

Parse out the first string upto the first `-` to get the integer id of the resource.

```
def get_book_from_slug!(slug) do
    [id |_] = slug |> String.split("-")
    get_book!(id)
end
```

That is how you can implement persistent URLs in Phoenix. Hope you like it and head on over to https://indiepaper.me to see it in action, and a big thanks to https://hashrocket.com/blog/posts/titled-url-slugs-in-phoenix for the initial ideas.

Happy Hacking Alchemist :D
