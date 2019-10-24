defmodule TestPhoenixWeb.QuestionsView do
    use TestPhoenixWeb, :view
    def get_route(conn, cat_route) do
        if cat_route != nil and cat_route != "" do
            Routes.questions_path(conn, :index) <> "?category=" <> cat_route
        else
            Routes.questions_path(conn, :index)
        end
    end
    def readable_date(date) do
        {:ok, parsed, _} = DateTime.from_iso8601(date)
        Integer.to_string(parsed.month) <> "/" <> Integer.to_string(parsed.day) <> "/" <> Integer.to_string(parsed.year)
    end
end
  