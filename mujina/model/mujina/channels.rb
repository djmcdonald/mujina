require 'active_support/core_ext/numeric'
require 'model/mujina/channel'
require 'model/mujina/show'
require 'support/time'

class Channels
  def initialize(start_time, end_time)
    @start_time = start_time
    @end_time = end_time
    @channels = Array.new
  end

  def add_channel(channel)
    @channels.push channel
  end

  def to_json(*a)
    show = Show.new(1, '2014-01-25T12:45:00Z', '2014-01-25T12:55:00Z', 'This is a show', 'A small description', 'Comedy', true)
    show2 = Show.new(1, '2014-01-25T12:55:00Z', '2014-01-25T13:35:00Z', 'Eastenders', 'A small description', 'Comedy', true)

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