require 'model/mujina/show'

class Channel
  def initialize
    @id = 123
    @call_sign = 'BBC One' + Random.rand(11).to_s
    @shows = Array.new

    #@shows.push Show.new
    #@shows.push Show.new
  end

  def add_show(show)
    @shows.push show
  end

  def to_json(*a)
    {
        :id => @id,
        :call_sign => @call_sign,
        :shows => @shows
    }.to_json(*a)
  end
end