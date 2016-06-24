FROM ruby:2.3.0
RUN apt-get update -qq && apt-get install -y build-essential

ENV APP_HOME /waypoint
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ENV BUNDLE_PATH /box

ADD . $APP_HOME
