require 'compass'
require 'sinatra'
require 'json'
require 'services/converter/mythtv_api_converter'
require 'active_support/core_ext/numeric'
require 'support/time'

before do
  @mythtv_converter = MythTVAPIConverter.new
end

configure do
  set :scss, {:debug_info => true}
  Compass.add_project_configuration(File.join(Sinatra::Application.root, 'config', 'compass.config'))
end

get '/stylesheets/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  scss :"stylesheets/#{params[:name]}", Compass.sass_engine_options
end

get '/tv/guide' do
  @title = 'TV Guide - Mujina'
  @header = 'TV Guide'
  erb :tv_guide
end

get '/api/tv/guide/channels', :provides => 'json' do
  guide_start_time = Time.now.floor(1.hour)
  guide_end_time = guide_start_time + 1.hour
  @mythtv_converter.tv_guide guide_start_time, guide_end_time
end

get '/api/tv/guide/channels/:start', :provides => 'json' do |start|
  guide_start_time = DateTime.parse(start).to_time
  guide_end_time = guide_start_time + 1.hour
  @mythtv_converter.tv_guide guide_start_time, guide_end_time
end

get '/api/tv/guide/:start_date/:end_date', :provides => 'json' do |start_date, end_date|
  File.read("fixtures/tv_guide.json")
end

get '/tv/channel/:id/icon', :provides => 'jpeg' do |id|
  File.read("fixtures/channel_icon.jpg")
end
