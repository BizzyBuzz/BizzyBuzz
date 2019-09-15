# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sales_by_vendor,
  ecto_repos: [SalesByVendor.Repo]

# Configures the endpoint
config :sales_by_vendor, SalesByVendorWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "d7yl4t2TJb7iq3ORtjxl8cF1l8iaFEam9JBM2+zjtPdMOHrP/su1PMuOWcEcHkuf",
  render_errors: [view: SalesByVendorWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SalesByVendor.PubSub, adapter: Phoenix.PubSub.PG2]

config :logger, 
  backends: [:console, {LoggerFileBackend, :info_log}],
  format: "[$level] $message\n", 
  truncate: :infinity

config :logger, :info_log, 
  path: "/tmp/info.log",
  level: :info, 
  truncate: :infinity

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
