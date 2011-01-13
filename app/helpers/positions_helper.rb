module PositionsHelper
  def positions_for_select(selected)

    positions = Position.find(:all)

    collection = ['None'=>nil]

    positions.each { |u|
      if selected.id!=u.id
        collection << [u.title, u.id]
      end
    }

    collection
  end

  def users_list()

    users = User.find(:all, :conditions => ["status=?", 1])

    users
  end

  def positions_index()
    link_to l(:label_position_plural), url_for(:controller => 'positions', :action=>'index')
  end
end
