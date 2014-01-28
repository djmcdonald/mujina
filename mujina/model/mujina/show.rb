class Show
  def initialize(id, start_time, end_time, title, description, category, repeat)
    @id = id
    @start_time = DateTime.parse(start_time)
    @end_time = DateTime.parse(end_time)
    puts "****** st=" + @start_time.to_s + " et =" + @end_time.to_s
    @title = title
    @description = description
    @category = category
    @repeat = repeat
  end

  #    @start_time = '2014-01-25T12:45:00Z'
  #@end_time = '2014-01-25T13:45:00Z'
  #@title = 'This is a test'
  #@category = 'Comedy'
  #@repeat = false

  def duration_in_words
    'five'
  end

  def to_json(*a)
    {
        :show => {
            :id => @id,
            :start_time => @start_time,
            :end_time => @end_time,
            :title => @title,
            :description => @description,
            :category => @category,
            :repeat => @repeat,
            :duration => 'five'
        }
    }.to_json(*a)
  end
end