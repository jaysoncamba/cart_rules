FROM ruby:3.3.3

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /cart_rules

COPY Gemfile* ./
RUN bundle install

COPY . .

CMD ["bin/rails", "server", "-b", "0.0.0.0"]