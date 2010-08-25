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
  
  def social_buttons
    apps4edmonton = link_to "Vote for us @ Apps for Edmonton!", "http://contest.apps4edmonton.ca/apps/17", :class => "sexybutton sexysimple sexyblue"
    twitter = link_to image_tag('twitter-icon.png'), "http://twitter.com/Alertzy"
    facebook = link_to image_tag('facebook-icon.png'), "http://www.facebook.com/home.php?#!/pages/Alertzy/153604841323348?ref=ts"
    apps4edmonton + twitter + facebook
  end
  
  def get_satisfaction_feedback_widget
    <<-EOF
    <script type="text/javascript" charset="utf-8">
      var is_ssl = ("https:" == document.location.protocol);
      var asset_host = is_ssl ? "https://s3.amazonaws.com/getsatisfaction.com/" : "http://s3.amazonaws.com/getsatisfaction.com/";
      document.write(unescape("%3Cscript src='" + asset_host + "javascripts/feedback-v2.js' type='text/javascript'%3E%3C/script%3E"));
    </script>

    <script type="text/javascript" charset="utf-8">
      var feedback_widget_options = {};

      feedback_widget_options.display = "overlay";  
      feedback_widget_options.company = "alertzy";
      feedback_widget_options.placement = "left";
      feedback_widget_options.color = "#222";
      feedback_widget_options.style = "idea";








      var feedback_widget = new GSFN.feedback_widget(feedback_widget_options);
    </script>
    EOF
  end
  
  def google_analytics
    <<-EOF
    <script type="text/javascript">

  	  var _gaq = _gaq || [];
  	  _gaq.push(['_setAccount', 'UA-18119673-1']);
  	  _gaq.push(['_trackPageview']);

  	  (function() {
  	    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
  	    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
  	    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  	  })();

  	</script>
  	EOF
	end
end