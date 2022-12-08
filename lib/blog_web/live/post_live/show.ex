defmodule BlogWeb.PostLive.Show do
  use BlogWeb, :live_view

  alias Blog.Posts

  @impl true
  def mount(%{"id" => post_id}, _, socket) do
    post = Posts.get_post!(post_id)

    meta_attrs = [
      %{name: "description", content: post.description}
    ]

    {:ok, assign(socket, post: post, page_title: post.title, meta_attrs: meta_attrs)}
  end
end
