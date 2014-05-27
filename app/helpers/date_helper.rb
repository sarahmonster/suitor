module DateHelper

  # take a regular old date and turn it into something human-parseable
  def friendly_date(date)
    # today
    if Date.today > date
      date.strftime("today at %l:%M %P")  
    # tomorrow
    elsif Date.tomorrow > date
      date.strftime("tomorrow at %l:%M %P")
    # this week: this Thursday at 5pm
    elsif Date.current.advance(days: 6) > date
      date.strftime("this %A at %l:%M %P")      
    # next week: next Thursday, March 28th
    elsif Date.current.advance(days: 14) > date
      date.strftime("next %A, %B %d")
    # default
    else
      date.strftime("%B %d")
    end
  end

end
