class TopMenuBuilder < TabsOnRails::Tabs::Builder
  def tab_for(tab, name, options, item_options = {})
    if item_options[:class]
      item_options[:class] += (current_tab?(tab) ? ' current' : '')
    else
      item_options[:class] = (current_tab?(tab) ? 'current' : '')
    end
    @context.content_tag(:li, item_options) do
      @context.link_to(@context.content_tag(:span,name), options)
    end
  end
  
  def open_tabs(options = {})
    @context.tag("ul", options, open = true)
  end

  def close_tabs(options = {})
    "</ul>".html_safe
  end
end

