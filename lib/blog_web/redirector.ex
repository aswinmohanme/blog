defmodule BlogWeb.Redirector do
  use Plug.Redirect

  redirect("/posts/superfast-vercel-liveview-fly", "/superfast-liveview", status: 302)
  redirect("/posts/better-fonts-on-linux", "/better-fonts-on-linux", status: 302)
end
