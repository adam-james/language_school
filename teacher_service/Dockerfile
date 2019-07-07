FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y postgresql-client apt-transport-https

LABEL Name=language_school Version=0.0.1
EXPOSE 3000

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app
COPY . /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

CMD ["bundle", "exec", "rails", "server", "--binding", "0.0.0.0"]
