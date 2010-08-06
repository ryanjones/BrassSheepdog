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
end