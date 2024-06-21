defmodule Mix.Tasks.Post.New do
  @moduledoc "The post.new mix task creates a new post"
  use Mix.Task

  def run(_) do
    [_mix_task_name, file_name] = System.argv()
    %{day: day, month: month, year: year} = Date.utc_today()

    content_path =
      Path.join("priv/content/posts", "/#{year}/#{month}-#{day}-#{file_name}.md")
      |> IO.inspect()

    File.mkdir_p!(Path.dirname(content_path))

    content = """
    %{
      title: "Title",
      tags: ~w(),
      description: "Description",
      draft: true
    }

    ---

    """

    File.write(content_path, content) |> IO.inspect()
  end
end
