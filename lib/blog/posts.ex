defmodule Blog.Posts do
  defmodule NotFoundError, do: defexception([:message, plug_status: 404])

  alias Blog.Posts.Post

  use NimblePublisher,
    build: Post,
    from: Application.app_dir(:blog, "priv/content/posts/**/*.md"),
    as: :posts,
    highlighters: [:makeup_elixir, :makeup_erlang]

  @posts Enum.sort_by(@posts, & &1.date, {:desc, Date})

  @tags @posts |> Enum.flat_map(& &1.tags) |> Enum.uniq() |> Enum.sort()

  def list_posts, do: @posts
  def all_tags, do: @tags

  def get_post_by_id!(id) do
    Enum.find(list_posts(), &(&1.id == id)) ||
      raise NotFoundError, "post with id=#{id} not found"
  end

  def get_posts_by_tag!(tag) do
    case Enum.filter(list_posts(), &(tag in &1.tags)) do
      [] -> raise NotFoundError, "posts with tag=#{tag} not found"
      posts -> posts
    end
  end
end
