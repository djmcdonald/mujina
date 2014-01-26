require 'sinatra'
require 'haml'
require 'hamlbars'


get '/' do
  @title = 'Mujina'
  @page_header = 'Mujina'
  haml :index
end

get '/tv/guide' do
  @title = 'TV Guide - Mujina'
  @page_header = 'TV Guide'
  haml :tv_guide
end

get '/api/tv/guide/:start_date/:end_date', :provides => 'json' do |start_date, end_date|
  File.read("fixtures/tv_guide.json")
end

get '/api/tv/channel/:id/icon', :provides => 'jpeg' do |id|
  File.read("fixtures/channel_icon.jpg")
end
