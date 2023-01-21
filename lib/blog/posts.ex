defmodule Blog.Posts do
  defmodule NotFoundError, do: defexception([:message, plug_status: 404])

  alias Blog.Posts.Post

  @show_drafts Application.compile_env(:blog, :show_drafts, false)

  use NimblePublisher,
    build: Post,
    from: Application.app_dir(:blog, "priv/content/posts/**/*.md"),
    as: :posts

  @posts Enum.sort_by(@posts, & &1.date, {:desc, Date})

  def list_posts do
    if @show_drafts do
      @posts
    else
      @posts |> Enum.reject(fn post -> post.draft end)
    end
  end

  def list_tags do
    list_posts() |> Enum.flat_map(& &1.tags) |> Enum.uniq() |> Enum.sort()
  end

  def get_post!(id) do
    Enum.find(@posts, &(&1.id == id)) ||
      raise NotFoundError, "post with id=#{id} not found"
  end

  def list_posts_by_tag!(tag) do
    case Enum.filter(list_posts(), &(tag in &1.tags)) do
      [] -> raise NotFoundError, "posts with tag=#{tag} not found"
      posts -> posts
    end
  end
end
