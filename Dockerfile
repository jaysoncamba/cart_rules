FROM ruby:3.3.3

# Add Node.js and Yarn
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install --global yarn

# Install OS-level dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  postgresql-client \
  curl

# Set the working directory
WORKDIR /cart_rules

# Copy Gemfile and lockfile first (for caching)
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the rest of the app
COPY . .

# Ensure tmp dir exists
RUN mkdir -p tmp

# Default CMD is overridden by docker-compose
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
