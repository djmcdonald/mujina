require 'model/mujina/show'

class Channel
  def initialize(id, number, call_sign)
    @id = id
    @number = number
    @call_sign = call_sign
    @shows = Array.new
  end

  def add_show(show)
    @shows.push show
  end

  def to_json(*a)
    {
        :id => @id,
        :number => @number,
        :call_sign => @call_sign,
        :shows => @shows
    }.to_json(*a)
  end
end