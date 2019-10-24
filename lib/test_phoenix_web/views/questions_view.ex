defmodule TestPhoenixWeb.QuestionsView do
    use TestPhoenixWeb, :view
    def get_route(conn, cat_route) do
        if cat_route != nil and cat_route != "" do
            Routes.questions_path(conn, :index) <> "?category=" <> cat_route
        else
            Routes.questions_path(conn, :index)
        end
    end
end
  