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
    {
        'duration' => duration,
        'start_time' => @start_time,
        'end_time' => @end_time,
        'channels' => @channels
    }.to_json(*a)
  end

  private
  def duration
    (@end_time - @start_time).to_i
  end
end