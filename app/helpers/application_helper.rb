module ApplicationHelper

  def formatted_date date
    date.strftime("%B-%d at %I:%M%p")
  end

end
