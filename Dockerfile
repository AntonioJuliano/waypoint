FROM ruby:2.3.0
RUN apt-get update -qq && apt-get install -y build-essential

ENV APP_HOME /waypoint
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME