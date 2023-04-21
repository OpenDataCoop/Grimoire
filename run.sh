#!/bin/bash
# Docker entrypoint script.

# Install Elixir dependencies
mix deps.get

# Set up the Ecto database
mix ecto.create
mix ecto.migrate

# Run Phoenix server
mix phx.server
