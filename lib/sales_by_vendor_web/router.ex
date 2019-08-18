defmodule SalesByVendorWeb.Router do
  use SalesByVendorWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug SalesByVendorWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SalesByVendorWeb do
    pipe_through :browser
    
    get "/", PageController, :dashboard
    get "/sales-by-vendor/:id", PageController, :index
    resources "/password", PasswordController, only: [:new, :create]
    get "/reset-password", PasswordController, :edit
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/users", UserController, only: [:index, :show, :new, :create]
    put "/update-password/:token", PasswordController, :update
    get "/verify", UserController, :verify_email
    get "/*path", PageController, :dashboard
  end

  # Other scopes may use custom stacks.
  scope "/api", SalesByVendorWeb do
    pipe_through :api
    
    post "/insert_new_sales", PageController, :insert_new_sales
  end
end
