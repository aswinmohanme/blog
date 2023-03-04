defmodule BlogWeb.PageView do
  use BlogWeb, :view

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

    "#{date.year}-#{month_name}-#{if date.day < 10, do: '0'}#{date.day}"
  end
end
