module PartialsHelper
  def logged_in?
    @user.present?
  end

  def render_partial(template)
    erb template, :layout => false
  end

  def show_flash(key)
    if session[key]
      flash = session[key]
      session[key] = false
      flash
    end
  end

  def title
    if @title
      "#{@title} -- My Blog"
    else
      "My Blog"
    end
  end

  def pretty_date(time)
    #time.strftime("%d %b %Y")
    time.strftime("%I:%M%p")
  end
end

