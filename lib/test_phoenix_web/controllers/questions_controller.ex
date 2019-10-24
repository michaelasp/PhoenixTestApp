defmodule TestPhoenixWeb.QuestionsController do
    use TestPhoenixWeb, :controller
    alias TestPhoenix.ApiInterface
    def index(conn, params) do
        random_q = ApiInterface.get_random
        questions = ApiInterface.get_questions(params)
        cat_route = get_in(params, ["category"])
        if cat_route == nil do cat_route = "" end
        IO.puts(cat_route)
        render(conn, "index.html", question: random_q, question_list: questions, cat_route: cat_route)
      end
    def category(conn, params) do
      category_list = ApiInterface.get_cat(params)
      render(conn, "category.html", category_list: category_list)
    end
    end
    