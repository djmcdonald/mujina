class Show
  def initialize(id, start_time, end_time, title, description, category, repeat)
    @id = id
    @start_time = DateTime.parse(start_time)
    @end_time = DateTime.parse(end_time)
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
        :duration_class => duration_class
    }.to_json(*a)
  end

  private

  def duration_class
    difference = ((@end_time - @start_time) * 24 * 60).to_i

    # The whole grid represents 120 minutes
    if difference == 120
      '10'
    elsif difference == 90
      '7-5'
    elsif difference == 60
      '5'
    elsif difference == 10
      '0-8'
    end
  end
end