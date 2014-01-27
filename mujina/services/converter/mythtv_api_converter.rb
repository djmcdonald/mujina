require 'json'

class MythTVAPIConverter
  def tv_guide(start_date_time = nil)
    { :products => [ { :id => 1, :title => 'Rube Goldberg Breakfast-o-Matic' } ] }.to_json
  end
end