defmodule CleanCodeWeb.Router do
  use CleanCodeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CleanCodeWeb do
    pipe_through :api
  end
end
