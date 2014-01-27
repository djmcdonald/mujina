require 'json'

class Shows
  def initialize
    @shows = Array.new
    @shows.push({ :id => 1, :title => 'test_show' })
  end

  def to_json(*a)
    {
        'shows' => @shows
    }.to_json(*a)
  end
end