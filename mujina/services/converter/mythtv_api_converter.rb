require 'json'
require 'model/shows'

class MythTVAPIConverter
  def tv_guide(start_date_time = nil)
    show = Shows.new
    JSON.dump(show)
  end
end