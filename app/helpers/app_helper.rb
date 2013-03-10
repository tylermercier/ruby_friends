module AppHelper
  def logged_in?
    @current_user.present?
  end

  def pretty_date(time)
    time.strftime("%d %b %Y")
  end

  def pretty_time(time)
    time.strftime("%I:%M%p")
  end
end

