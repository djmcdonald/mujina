require 'model/mujina/channel'

class Channels
  def initialize
    @channels = Array.new
  end

  def add_channel(channel)
    @channels.push channel
  end

  def to_json(*a)
    @channels.push (Channel.new)
    @channels.push (Channel.new)
    {
        'channels' => @channels
    }.to_json(*a)
  end
end