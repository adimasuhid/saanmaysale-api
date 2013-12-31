require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'json'
require './api/app-api.rb'
require './app.rb'

set :environment, :development
set :run, false
set :raise_errors, true

run Sinatra::Application

