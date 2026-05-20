import Config

# The HTTP client reads `base_url`, `timeout`, `app_id`, `app_secret`, and
# `req_options` from `Application.get_env(:contify, ...)`. Defaults live in
# `ContifyAPI.Client`. The application using this library is responsible for
# providing `:app_id` and `:app_secret`.

if File.exists?(Path.join(__DIR__, "#{config_env()}.exs")) do
  import_config "#{config_env()}.exs"
end
