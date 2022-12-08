defmodule BlogWeb.Features.VisitorCanSeeNameOnHomePageTest do
  use BlogWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "visitor can see my name on home page", %{conn: conn} do
    {:ok, _view, html} = live(conn, Routes.page_path(conn, :index))

    assert html =~ "aswinmohan.me"
  end

  test "visitor can see my about page page", %{conn: conn} do
    {:ok, _view, html} = live(conn, Routes.page_path(conn, :about))

    assert html =~ "About"
  end
end
