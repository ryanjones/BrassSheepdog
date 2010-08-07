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
  
  def default_text(text)
    onClickFunction = "field = event.target; if (field.value=='#{text}') {field.value = '';}else {return false}"
    onBlurFunction = "field = event.target; if (field.value=='') {field.value = '#{text}';}else {return false}"
    {:value => text, :onclick => onClickFunction, :onblur => onBlurFunction}
  end
end