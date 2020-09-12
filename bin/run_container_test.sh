#!/usr/bin/env dash

export RAILS_ENV=test

alias x='bundle exec'

x rails db:migrate
x rspec 