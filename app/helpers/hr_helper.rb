module HrHelper

  def hr_index()
     link_to l(:label_hr), url_for(:controller => 'hr', :action=>'index')
  end

end
