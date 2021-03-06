defmodule MediathekWeb.Router do
  use MediathekWeb, :router

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

  scope "/", MediathekWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", MediathekWeb do
    pipe_through :api

    get "/directory", DirectoryController, :index
    get "/directory/:path", DirectoryController, :show
  end
end
