module HrHelper

  def hr_index()
    link_to l(:label_hr), url_for(:controller => 'hr', :action=>'index')
  end

  # Display a link if the user has a global permission
  def link_to_if_authorized_globally(name, options = {}, html_options = nil, *parameters_for_method_reference)
    if authorized_globally(options[:controller],options[:action])
      link_to(name, options, html_options, *parameters_for_method_reference)
    end
  end

  def authorized_globally(controller,action)
    User.current.allowed_to?({:controller => controller, :action => action},nil, :global => true)
  end

end
