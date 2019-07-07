FROM ruby:2.6.3 as base

RUN apt-get update -qq && apt-get install -y postgresql-client apt-transport-https

LABEL Name=language_school Version=0.0.1

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app
COPY . /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

FROM base as web_dev
EXPOSE 4000

CMD ["bundle", "exec", "rails", "server", "-p", "4000", "--binding", "0.0.0.0"]

FROM base as worker_dev

ENV Workers Teachers::CreatedWorker,Teachers::UpdatedWorker

CMD ["bundle", "exec", "rake", "sneakers:run"]
