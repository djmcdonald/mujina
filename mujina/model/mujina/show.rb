class Show
  def initialize
    @start_time = '2014-01-25T12:45:00Z'
    @end_time = '2014-01-25T13:45:00Z'
    @title = 'This is a test'
    @category = 'Comedy'
    @repeat = false
  end

  def to_json(*a)
    {
        :show => {
            :id => 1,
            :start_time => @start_time,
            :end_time => @end_time,
            :title => @title,
            :category => @category,
            :repeat => @repeat
        }
    }.to_json(*a)
  end
end