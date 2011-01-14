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


  def rows_style()
    properties=[
      #      {:selected => {:from => '#FFDFDF', :to => '#FFBBBB', :border => '#FF9797'}, :style => {:from => '#FF9797', :to => '#FF7575',:border => '#FF4848'}},

      {:style => {:'from' => '#D6F8DE', :'to' => '#E3FBE9',:'border' => '#93EEAA'}},
      {:style => {:'from' => '#DBEADC', :'to' => '#E9F1EA',:'border' => '#A6CAA9'}},
      {:style => {:'from' => '#DFFFCA', :'to' => '#E8FFD9',:'border' => '#ABFF73'}},
      {:style => {:'from' => '#FFFFC8', :'to' => '#FFFFD7',:'border' => '#FFFF84'}},
      {:style => {:'from' => '#CACAFF', :'to' => '#E1E1FF',:'border' => '#9999FF'}},
      {:style => {:'from' => '#D0E6FF', :'to' => '#DBEBFF',:'border' => '#99C7FF'}},
      {:style => {:'from' => '#D9F3FF', :'to' => '#ECFAFF',:'border' => '#A8E4FF'}},
      {:style => {:'from' => '#CAFFD8', :'to' => '#EAFFEF',:'border' => '#8BFEA8'}},
      {:style => {:'from' => '#E8C6FF', :'to' => '#EFD7FF',:'border' => '#C269FE'}},
      {:style => {:'from' => '#D7D1F8', :'to' => '#E3E0FA',:'border' => '#A095EE'}},
      {:style => {:'from' => '#B8E2EF', :'to' => '#C9EAF3',:'border' => '#57BCD9'}},
      {:style => {:'from' => '#FFC8F2', :'to' => '#FFDFF8',:'border' => '#FFACEC'}},
      {:style => {:'from' => '#DDCEFF', :'to' => '#E6DBFF',:'border' => '#C4ABFE'}}
      
    ]

    properties
  end

  def display_rows_style(depth)
    string=''

    for i in 0..depth
      style = rows_style[i]
      string +="data.setRowProperty("+ (i.to_s) +", 'style', 'background: -webkit-gradient(linear, 0% 0%, 0% 100%, from("+style[:style][:from]+"), to("+style[:style][:to]+"));border: 2px solid "+style[:style][:border]+"');
"

      string +="data.setRowProperty("+(i.to_s) +", 'selectedStyle', 'background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#FFFFC8), to(#FFFFD7));border: 2px solid #FFFF84');
"

      #      string +="data.setRowProperty("+(i.to_s) +", 'selectedStyle', 'background: -webkit-gradient(linear, 0% 0%, 0% 100%, from("+style[:selected][:from]+"), to("+style[:selected][:to]+"));border: 2px solid "+style[:selected][:border]+"');
      #"
    
    end
    string
  end


end
