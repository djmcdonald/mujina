require 'active_support/core_ext/numeric'
require 'model/mujina/channel'
require 'model/mujina/show'

class Time
  # Thanks to: https://stackoverflow.com/questions/449271/how-to-round-a-time-down-to-the-nearest-15-minutes-in-ruby
  # Time#round already exists with different meaning in Ruby 1.9
  def round_off(seconds = 60)
    Time.at((self.to_f / seconds).round * seconds)
  end

  def floor(seconds = 60)
    Time.at((self.to_f / seconds).floor * seconds)
  end
end

class Channels
  def initialize(start_time = nil)
    @start_time = start_time.floor(1.hour) || Time.now.floor(1.hour)
    @end_time = @start_time + 1.hour
    @channels = Array.new
  end

  def add_channel(channel)
    @channels.push channel
  end

  def to_json(*a)
    show = Show.new(1, '2014-01-25T12:45:00Z', '2014-01-25T12:55:00Z', 'This is a show', 'A small description', 'Comedy', true)
    show2 = Show.new(1, '2014-01-25T12:55:00Z', '2014-01-25T13:35:00Z', 'Eastenders', 'A small description', 'Comedy', true)
    first_channel = Channel.new(1, 101, "BBC One")
    first_channel.add_show show
    first_channel.add_show show2
    second_channel = Channel.new(2, 108, "BBC HD")

    @channels.push (first_channel)
    @channels.push (second_channel)
    {
        'duration' => duration,
        'start_time' => @start_time.strftime('%Y-%m-%d %H:%M:%S'),
        'end_time' => @end_time.strftime('%Y-%m-%d %H:%M:%S'),
        'channels' => @channels
    }.to_json(*a)
  end

  private
  def duration
    (@end_time - @start_time).to_i
  end
end