#!/bin/bash
set -e

# Remove pre-existing server.pid if present
rm -f /cart_rules/tmp/pids/server.pid

# Ensure DB is up before proceeding
echo "Waiting for database..."
until pg_isready -h db -U postgres; do
  sleep 1
done

bundle check || bundle install

# Setup DB if needed
echo "Running database setup..."
bundle exec rails db:prepare

# Run the main container command (from Dockerfile or docker-compose)
exec "$@"
