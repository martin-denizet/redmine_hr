module UserPositionsHelper
    def users_for_select()

    users = User.find(:all)

    collection = []

    users.each { |u| collection << [u.login, u.id] }

    options_for_select(collection)
  end
  
  def users_list()

    users = User.find(:all)

    users
  end
end
