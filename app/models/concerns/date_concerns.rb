module DateConcerns

  def format_yesterday
    yesterday = (DateTime.now - 1).to_s
    year = yesterday[0,4]
    month = yesterday[5,2]
    day = yesterday[8,2]
    "+AND+(%22#{year}%2F#{month}%2F#{day}%22%5B"
  end




end