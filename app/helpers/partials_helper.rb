# encoding: utf-8
module PartialsHelper
  def logged_in?
    not @user.nil?
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
   time.strftime("%d %b %Y")
  end

  def post_show_page?
    request.path_info =~ /\/posts\/\d+$/
  end

  def delete_post_button(post_id)
    erb :_delete_post_button, locals: { post_id: post_id}
  end
end

