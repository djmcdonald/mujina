require 'json'
require 'model/mujina/channels'

class MythTVAPIConverter
  def tv_guide(start_date_time = nil)
    JSON.dump(Channels.new)
  end
end