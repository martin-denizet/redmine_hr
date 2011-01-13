module HrHelper

  def hr_index()
     link_to l(:label_hr), url_for(:controller => 'hr', :action=>'index')
  end

  def authorized_globally(controller,action)
    User.current.allowed_to?({:controller => controller, :action => action},nil, :global => true)
  end

end
