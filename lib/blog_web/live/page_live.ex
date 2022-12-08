defmodule BlogWeb.PageLive do
  use BlogWeb, :live_view

  def render(%{live_action: :index} = assigns) do
    Phoenix.View.render(BlogWeb.PageView, "index.html", assigns)
  end

  def render(%{live_action: :about} = assigns) do
    Phoenix.View.render(BlogWeb.PageView, "about.html", assigns)
  end
end
