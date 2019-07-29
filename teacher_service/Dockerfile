FROM ruby:2.6.3 as base

RUN apt-get update -qq && apt-get install -y postgresql-client apt-transport-https

LABEL Name=language_school Version=0.0.1
EXPOSE 3000

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app
COPY . /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

FROM base as web_dev

CMD ["bundle", "exec", "rails", "server", "--binding", "0.0.0.0"]

FROM base as web_prod

ENV RAILS_ENV production
ENV RAILS_LOG_TO_STDOUT true

CMD ["bundle", "exec", "rails", "server", "--binding", "0.0.0.0"]
