require 'json'
require 'model/mujina/channel'
require 'model/mujina/channels'
require 'model/mujina/show'

class MythTVAPIConverter
  def tv_guide(start_date = nil)
    guide = Channels.new start_date

    response_body = File.read("fixtures/tv_guide.json")
    mythtv_response = JSON[response_body]

    sorted_channel_list = mythtv_response['ProgramGuide']['Channels'].sort_by{ |channel| channel['ChanNum'].to_i }
    sorted_channel_list.each do |sorted_channel|
      channel = Channel.new(sorted_channel['ChanId'], sorted_channel['ChanNum'], sorted_channel['CallSign'])

      sorted_channel['Programs'].each do |program|
        #(id, start_time, end_time, title, description, category, repeat)
        show = Show.new(
          1,
          program['StartTime'],
          program['EndTime'],
          program['Title'],
          program['SubTitle'],
          program['Category'],
          program['Repeat'])
        channel.add_show show
      end

      guide.add_channel channel
    end

    JSON[guide]
  end
end