FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem install bundler -v 2.0.2
RUN gem update --system
RUN bundle install
COPY . /myapp

# Add a script to be executed every time the container starts.
RUN rake assets:precompile
ENV RAILS_ENV production
RUN bundle exec sidekiq -q default
RUN rake db:create
RUN rake db:migrate

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]