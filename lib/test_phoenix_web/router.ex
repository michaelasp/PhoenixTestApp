defmodule TestPhoenixWeb.Router do
  use TestPhoenixWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TestPhoenixWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/questions", QuestionsController, :index
    post "/questions", QuestionsController, :index
    get "/questions/category", QuestionsController, :category
  end

  # Other scopes may use custom stacks.
  # scope "/api", TestPhoenixWeb do
  #   pipe_through :api
  # end
end
