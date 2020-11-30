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
ENV SECRET_KEY_BASE 02a6c11c0e218d3f070e12c1dde2437bf51c25cf2323df1acc06040708dcb4914e83e1af1996f949b1e8aa9d9bff5b76280eb737f3459f4d33433ca078e143ad
RUN rake db:create
RUN rake db:migrate

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]