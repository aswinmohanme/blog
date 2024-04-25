defmodule BlogWeb.Layouts do
  use BlogWeb, :html

  import Phoenix.HTML

  embed_templates "layouts/*"

  def meta_tags(attrs_list) do
    Enum.map(attrs_list, &meta_tag/1)
  end

  def meta_tag(attrs) do
    html_attrs = attributes_escape(Enum.into(attrs, [])) |> safe_to_string()
    raw("<meta #{html_attrs} />")
  end
end
