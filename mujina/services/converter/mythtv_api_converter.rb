require 'json'
require 'model/mujina/channel'
require 'model/mujina/channels'
require 'model/mujina/show'

class MythTVAPIConverter
  def tv_guide(guide_start_date, guide_end_date)
    id = 1
    guide = Channels.new guide_start_date, guide_end_date

    response_body = File.read("fixtures/tv_guide.json")
    mythtv_response = JSON[response_body]

    sorted_channel_list = mythtv_response['ProgramGuide']['Channels'].sort_by{ |channel| channel['ChanNum'].to_i }
    sorted_channel_list.each do |sorted_channel|
      channel = Channel.new(sorted_channel['ChanId'], sorted_channel['ChanNum'], sorted_channel['CallSign'])


      sorted_programmes = sorted_channel['Programs'].sort_by{ |programme| programme['StartTime'] }
      sorted_programmes.each do |program|
        programme_start_time = DateTime.parse(program['StartTime']).to_time
        if programme_start_time < guide_start_date
          programme_start_time = guide_start_date
        end

        programme_end_time = DateTime.parse(program['EndTime']).to_time
        if programme_end_time > guide_end_date
          programme_end_time = guide_end_date
        end

        #(id, start_time, end_time, title, description, category, repeat)
        show = Show.new(
          id,
          programme_start_time,
          programme_end_time,
          program['Title'],
          program['SubTitle'],
          program['Category'],
          program['Repeat'])
        channel.add_show show
        id+= 1
      end

      guide.add_channel channel
    end

    JSON[guide]
  end
end