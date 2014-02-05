require 'json'
require 'model/mujina/channel'
require 'model/mujina/channels'

class MythTVAPIConverter
  def tv_guide(start_date = nil)
    guide = Channels.new start_date

    response_body = File.read("fixtures/tv_guide.json")
    mythtv_response = JSON.parse(response_body)

    sorted_channel_list = mythtv_response['ProgramGuide']['Channels'].sort_by{ |channel| channel['ChanNum'].to_i }
    sorted_channel_list.each do |channel|
      channel = Channel.new(channel['ChanId'], channel['ChanNum'], channel['CallSign'])
      guide.add_channel channel
    end

    JSON.dump(guide)
  end
end