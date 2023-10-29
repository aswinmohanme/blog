defmodule BlogWeb.PageLive.Index do
  use BlogWeb, :live_view

  alias Blog.Posts

  @impl true
  def mount(%{}, _, socket) do
    posts = Posts.list_posts()
    top_posts = Posts.list_top_posts()
    tags = Posts.list_tags()

    meta_attrs = [
      %{
        name: "description",
        content:
          "Hey, I'm Aswin Mohan. I'm a Software Developer who works across frontend, backend, mobile and design. I am currently based out of Kerala, India. I love to design, code and make bold, beautiful, useful things."
      }
    ]

    {:ok,
     socket
     |> assign(posts: posts, tags: tags, meta_attrs: meta_attrs, top_posts: top_posts)}
  end

  def mount(_, _, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"tag" => tag}, _, %{assigns: %{live_action: :index}} = socket) do
    posts = Posts.list_posts_by_tag!(tag)
    {:noreply, socket |> assign(posts: posts)}
  end

  @impl true
  def handle_params(%{}, _, %{assigns: %{live_action: :index}} = socket) do
    posts = Posts.list_posts()
    {:noreply, socket |> assign(posts: posts)}
  end

  @impl true
  def handle_params(_, _, socket) do
    {:noreply, socket}
  end

  def format_published_date(%Date{month: month} = date) do
    month_name =
      case month do
        1 -> "Jan"
        2 -> "Feb"
        3 -> "Mar"
        4 -> "Apr"
        5 -> "May"
        6 -> "Jun"
        7 -> "Jul"
        8 -> "Aug"
        9 -> "Sep"
        10 -> "Oct"
        11 -> "Nov"
        12 -> "Dec"
      end

    "#{date.year}-#{month_name}-#{if date.day < 10, do: ~c"0"}#{date.day}"
  end
end
