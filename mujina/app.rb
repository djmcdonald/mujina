require 'sinatra'
require 'json'

get '/tv/guide' do
  @title = 'TV Guide - Mujina'
  @page_header = 'TV Guide'
  haml :index
end

get '/api/products', :provides => 'json' do
  content_type :json
  { :products => [ { :id => 1, :title => 'Rube Goldberg Breakfast-o-Matic' } ] }.to_json
end

get '/api/tv/guide/:start_date/:end_date', :provides => 'json' do |start_date, end_date|
  File.read("fixtures/tv_guide.json")
end

get '/api/tv/channel/:id/icon', :provides => 'jpeg' do |id|
  File.read("fixtures/channel_icon.jpg")
end
