defmodule SalesByVendorWeb.Router do
  use SalesByVendorWeb, :router

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

  scope "/", SalesByVendorWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/insert_new_sales", PageController, :insert_new_sales
  end

  # Other scopes may use custom stacks.
  # scope "/api", SalesByVendorWeb do
  #   pipe_through :api
  # end
end
