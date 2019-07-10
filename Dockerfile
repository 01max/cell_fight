FROM ruby:2.6.3
RUN mkdir /cell_fight
WORKDIR /cell_fight
COPY Gemfile /cell_fight/Gemfile
COPY Gemfile.lock /cell_fight/Gemfile.lock
# RUN bundle update
RUN gem install bundler
RUN bundle install
COPY . /cell_fight
