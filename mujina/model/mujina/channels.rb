class Channels
  def initialize
    @channels = Array.new
  end

  def add_channel(channel)
    @channels.push channel
  end

  def to_json(*a)
    @channels.push ({ :id => 1, :title => 'test' })
    {
        'channels' => @channels
    }.to_json(*a)
  end
end