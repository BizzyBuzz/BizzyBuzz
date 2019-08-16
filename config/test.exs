use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sales_by_vendor, SalesByVendorWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :sales_by_vendor, SalesByVendor.Repo,
  username: "postgres",
  password: "postgres",
  database: "sales_by_vendor_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
