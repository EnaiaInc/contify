import Config

# Optional runtime override for the Contify API base URL.
if base_url = System.get_env("CONTIFY_API_BASE_URI") do
  config :contify, base_url: base_url
end
