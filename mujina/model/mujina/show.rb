class Show
  def initialize(id, start_time, end_time, title, description, category, repeat)
    @id = id
    @start_time = start_time #DateTime.parse(start_time).to_time
    @end_time = end_time #DateTime.parse(end_time).to_time
    @title = title
    @description = description
    @category = category
    @repeat = repeat
  end

  def to_json(*a)
    {
        :id => @id,
        :start_time => @start_time,
        :end_time => @end_time,
        :title => @title,
        :description => @description,
        :category => @category,
        :repeat => @repeat,
        :duration => duration
    }.to_json(*a)
  end

  private

  def duration
    (@end_time - @start_time).to_i
  end
end