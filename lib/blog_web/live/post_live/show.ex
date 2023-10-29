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
