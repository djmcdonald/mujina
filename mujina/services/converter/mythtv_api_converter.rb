require 'json'
require 'model/mujina/channels'

class MythTVAPIConverter
  def tv_guide(start_date = nil)
    JSON.dump(Channels.new start_date)
  end
end