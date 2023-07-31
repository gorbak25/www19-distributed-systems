# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :libcluster,
  debug: true,
  topologies: [
    tailscale: [
      strategy: Cluster.Strategy.Tailscale,
      config: [
        authkey: System.get_env("TAILSCALE_APIKEY"),
        tailnet: "hedgehog-hen.ts.net",
        hostname: "erlang-workshop",
        appname: "mike"
      ]
    ]
  ]

# Configures the endpoint
config :day3, Day3Web.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: Day3Web.ErrorHTML, json: Day3Web.ErrorJSON],
    layout: false
  ],
  pubsub_server: Day3.PubSub,
  live_view: [signing_salt: "Ql4khuMQ"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :day3, Day3.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.3.2",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
