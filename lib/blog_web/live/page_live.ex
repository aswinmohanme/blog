defmodule BlogWeb.PageLive do
  use BlogWeb, :live_view

  alias Blog.Posts

  @impl true
  def mount(%{}, _, %{assigns: %{live_action: :index}} = socket) do
    posts = Posts.list_posts()
    tags = Posts.list_tags()

    meta_attrs = [
      %{
        name: "description",
        content:
          "Hey, I'm Aswin Mohan. I'm a Software Developer who works across frontend, backend, mobile and design. I am currently based out of Kerala, India. I love to design, code and make bold, beautiful, useful things."
      }
    ]

    {:ok, socket |> assign(posts: posts, tags: tags, meta_attrs: meta_attrs)}
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

  @impl true
  def render(%{live_action: :index} = assigns) do
    Phoenix.View.render(
      BlogWeb.PageView,
      "index.html",
      assigns
    )
  end

  def render(%{live_action: :about} = assigns) do
    Phoenix.View.render(BlogWeb.PageView, "about.html", assigns)
  end

  def render(%{live_action: :now} = assigns) do
    Phoenix.View.render(BlogWeb.PageView, "now.html", assigns)
  end

  def render(%{live_action: :talks} = assigns) do
    Phoenix.View.render(BlogWeb.PageView, "talks.html", assigns)
  end
end
