require 'sinatra'
require 'json'
require 'services/converter/mythtv_api_converter'

before do
  @mythtv_converter = MythTVAPIConverter.new
end

get '/tv/guide' do
  @title = 'TV Guide - Mujina'
  @page_header = 'TV Guide'
  erb :tv_guide
end

get '/api/tv/guide/channels', :provides => 'json' do
  @mythtv_converter.tv_guide
end

get '/api/tv/guide/:start_date/:end_date', :provides => 'json' do |start_date, end_date|
  File.read("fixtures/tv_guide.json")
end

get '/api/tv/channel/:id/icon', :provides => 'jpeg' do |id|
  File.read("fixtures/channel_icon.jpg")
end
