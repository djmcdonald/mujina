require 'model/mujina/channel'
require 'model/mujina/show'

class Channels
  def initialize
    @channels = Array.new
  end

  def add_channel(channel)
    @channels.push channel
  end

  def to_json(*a)
    show = Show.new(1, '2014-01-25T12:45:00Z', '2014-01-25T12:55:00Z', 'This is a show', 'A small description', 'Comedy', true)
    first_channel = Channel.new(1, 101, "BBC One")
    first_channel.add_show show
    second_channel = Channel.new(2, 108, "BBC HD")

    @channels.push (first_channel)
    @channels.push (second_channel)
    {
        'channels' => @channels
    }.to_json(*a)
  end
end