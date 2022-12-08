defmodule BlogWeb.Features.VisitorCanSeePostTest do
  use BlogWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias Blog.Posts

  test "visitor can see my about page page", %{conn: conn} do
    [post | _] = Posts.all_posts()

    {:ok, _view, html} = live(conn, Routes.post_show_path(conn, :show, post))

    assert html =~ post.title
  end
end
