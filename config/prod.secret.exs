use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :sales_by_vendor, SalesByVendor.Repo,
  # ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :sales_by_vendor, SalesByVendorWeb.Endpoint,
  http: [:inet6, port: String.to_integer(System.get_env("PORT") || "4000")],
  secret_key_base: secret_key_base

# config :sales_by_vendor, SalesByVendorWeb.Endpoint,
#   secret_key_base: "Apsn1sPQ640u5X6wUNcuyicloG+okxTuWobzE/b913Km9//S6r4+0Qxdwtj5u1eJ"

# Configure your database
# config :sales_by_vendor, SalesByVendor.Repo,
#   username: "postgres",
#   password: "postgres",
#   database: "sales_by_vendor_prod",
#   pool_size: 15
