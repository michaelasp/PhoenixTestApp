defmodule TestPhoenixWeb.QuestionsController do
    use TestPhoenixWeb, :controller
    alias TestPhoenix.ApiInterface
    def index(conn, params) do
        random_q = ApiInterface.get_random
        questions = ApiInterface.get_questions(params)
        render(conn, "index.html", question: random_q, question_list: questions)
      end
    def category(conn, params) do
      category_list = ApiInterface.get_cat(params)
      render(conn, "category.html", category_list: category_list)
    end
    end
    