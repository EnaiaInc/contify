import Config

# Stub credentials so tests can build a Req client. The Req.Test plug below
# intercepts every request, so these never hit the network.
config :contify,
  app_id: "test-app-id",
  app_secret: "test-app-secret",
  req_options: [plug: {Req.Test, ContifyAPI.Client}]
