# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # Return a title on a per-page basis.
  def title
    base_title = "Alertzy"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{h(@title)}"
    end
  end
  
  #Returns an image tag containing the project logo
  def logo
    image_tag "logo.png", :alt => "Alertzy", :class => "round"
  end
  
  def header_link_class
    if @header_link_class.nil?
      "home"
    else
      @header_link_class
    end
  end
  
  def forgot_password_button
    link_to "Forgot Password?", forgot_users_path, :class => "sexybutton sexysimple sexylightgrey"
  end
  
  def default_text(text)
    onFocusFunction = "field = event.target || event.srcElement; if (field.value=='#{text}') {field.value = '';}else {return false}"
    onBlurFunction = "field = event.target || event.srcElement; if (field.value=='') {field.value = '#{text}';}else {return false}"
    {:value => text, :onfocus => onFocusFunction, :onblur => onBlurFunction}
  end
end