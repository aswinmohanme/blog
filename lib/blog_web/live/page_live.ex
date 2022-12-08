defmodule BlogWeb.PageLive do
  use BlogWeb, :live_view

  alias Blog.Posts

  def render(%{live_action: :index} = assigns) do
    posts = Posts.list_posts()
    Phoenix.View.render(BlogWeb.PageView, "index.html", assigns |> Map.put(:posts, posts))
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
