

EC2:

DEPLOYMENT

Backup database process:

backup database from remote server to dump file, 

$ sudo -u ubuntu pg_dump "source db name" > "target_db_name_m-d-yyyy.sql

secure copy the file down to your local do this from your local (on mac), 

$ scp -i "identity file" "username@ip_address:/source path and filename" "target path"

RESTORE

psql> create database "db_name_m-d-yyyy";

$ psql db_name-m-d-yyyy < infile.sql 

LOGS

vim /tmp/info.log or wherever the log file is located in config.exs. You can use Shift+G to get to the end of the file, denoted by "END." 


HEROKU:

DEPLOYMENT

follow https://hexdocs.pm/phoenix/heroku.html

with the following database commands

```
$ heroku pg:reset postgresql-tapered-12363

$ heroku run "POOL_SIZE=2 mix ecto.migrate"

$ heroku run "POOL_SIZE=2 mix run priv/repo/seeds.exs"
```

IF YOU CHANGE OR ADD AND ENV VARIABLE, EVEN THRU HEROKU INTERFACE, YOU HAVE TO REDEPLOY AT LEAST A SPACE, because the elixir_buildpack.config forces recompilation, that includes compiling with new env. var. values, and that force recomplie is only activated with a deploy.

Url is https://bizzybuzzportal.com

BACK UP DATABASE

$ heroku pg:pull DATABASE_URL sales_by_vendor_prod_m_d_yyyy



<!-- # SalesByVendor

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix -->
