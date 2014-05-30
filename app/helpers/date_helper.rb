module DateHelper

  # take a regular old date and turn it into something human-parseable
  def friendly_date(datetime)
    date = datetime.to_date

    # yesterday: yesterday
    if date == Date.yesterday
      datetime.strftime("yesterday")
    # any other time in the past
    elsif date < Date.yesterday
      return "in the past"
    # today: today at 5pm
    elsif date == Date.today
      datetime.strftime("today at %l:%M %P")
    # tomorrow: tomorrow at 5pm
    elsif date == Date.tomorrow 
      datetime.strftime("tomorrow at %l:%M %P")
    # this week: this Thursday at 5pm
    elsif date < Date.current.advance(days: 7)
      datetime.strftime("this %A at %l:%M %P")      
    # next week: next Thursday, March 28th
    elsif date < Date.current.advance(days: 14)
      datetime.strftime("next %A, %B %d")
    # default
    else
      datetime.strftime("%B %d")
    end
  end

end
