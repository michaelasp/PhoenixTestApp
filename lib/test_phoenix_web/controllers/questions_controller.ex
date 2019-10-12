defmodule TestPhoenixWeb.QuestionsController do
    use TestPhoenixWeb, :controller
    alias TestPhoenix.ApiInterface
    def index(conn, _params) do
        random_q = ApiInterface.get_random
            
        render(conn, "index.html", question: random_q)
      end
    end
    