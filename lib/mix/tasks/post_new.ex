defmodule Mix.Tasks.Post.New do
  @moduledoc "The post.new mix task creates a new post"
  use Mix.Task

  def run(_) do
    [_mix_task_name, file_name] = System.argv()

    date =
      Date.utc_today()

    date_path =
      :io_lib.format("~4..0B/~2..0B-~2..0B", [date.year, date.month, date.day])
      |> IO.iodata_to_binary()

    content_path =
      Path.join("priv/content/posts", "/#{date_path}-#{file_name}.md")
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
