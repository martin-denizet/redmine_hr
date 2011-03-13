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

      
			{:style => {:'from' => '#DFB0FF', :'to' => '#C269FE',:'border' => '#9A03FE'}},
      {:style => {:'from' => '#D0E6FF', :'to' => '#99C7FF',:'border' => '#62A9FF'}},
      {:style => {:'from' => '#D9F3FF', :'to' => '#A8E4FF',:'border' => '#62D0FF'}},
      {:style => {:'from' => '#DBEADC', :'to' => '#A6CAA9',:'border' => '#59955C'}},
      {:style => {:'from' => '#F7F9D0', :'to' => '#EEF093',:'border' => '#B6BA18'}},
      {:style => {:'from' => '#FFE2C8', :'to' => '#FFC895',:'border' => '#FF800D'}},
      {:style => {:'from' => '#EEEECE', :'to' => '#E9E9BE',:'border' => '#D1D17A'}},
      {:style => {:'from' => '#EFE7CF', :'to' => '#E3D6AA',:'border' => '#C0A545'}},
			{:style => {:'from' => '#EACDC1', :'to' => '#D69E87',:'border' => '#B05F3C'}},
      {:style => {:'from' => '#ECD9D9', :'to' => '#D7ACAC',:'border' => '#B96F6F'}},
      {:style => {:'from' => '#F4CAD6', :'to' => '#E994AB',:'border' => '#B9264F'}},
			{:style => {:'from' => '#C6C6FF', :'to' => '#9191FF',:'border' => '#0000CE'}},
      {:style => {:'from' => '#E6DBFF', :'to' => '#C4ABFE',:'border' => '#9669FE'}},
      {:style => {:'from' => '#DCEDEA', :'to' => '#A5D3CA',:'border' => '#4A9586'}},
      {:style => {:'from' => '#F9D9FF', :'to' => '#EFA9FE',:'border' => '#E469FE'}},

      #Copy of the lines above
      
			{:style => {:'from' => '#DFB0FF', :'to' => '#C269FE',:'border' => '#9A03FE'}},
      {:style => {:'from' => '#D0E6FF', :'to' => '#99C7FF',:'border' => '#62A9FF'}},
      {:style => {:'from' => '#D9F3FF', :'to' => '#A8E4FF',:'border' => '#62D0FF'}},
      {:style => {:'from' => '#DBEADC', :'to' => '#A6CAA9',:'border' => '#59955C'}},
      {:style => {:'from' => '#F7F9D0', :'to' => '#EEF093',:'border' => '#B6BA18'}},
      {:style => {:'from' => '#FFE2C8', :'to' => '#FFC895',:'border' => '#FF800D'}},
      {:style => {:'from' => '#EEEECE', :'to' => '#E9E9BE',:'border' => '#D1D17A'}},
      {:style => {:'from' => '#EFE7CF', :'to' => '#E3D6AA',:'border' => '#C0A545'}},
			{:style => {:'from' => '#EACDC1', :'to' => '#D69E87',:'border' => '#B05F3C'}},
      {:style => {:'from' => '#ECD9D9', :'to' => '#D7ACAC',:'border' => '#B96F6F'}},
      {:style => {:'from' => '#F4CAD6', :'to' => '#E994AB',:'border' => '#B9264F'}},
			{:style => {:'from' => '#C6C6FF', :'to' => '#9191FF',:'border' => '#0000CE'}},
      {:style => {:'from' => '#E6DBFF', :'to' => '#C4ABFE',:'border' => '#9669FE'}},
      {:style => {:'from' => '#DCEDEA', :'to' => '#A5D3CA',:'border' => '#4A9586'}},
      {:style => {:'from' => '#F9D9FF', :'to' => '#EFA9FE',:'border' => '#E469FE'}},
      
    ]

    properties
  end

  def display_rows_style(map)
    string=''
    i=0
    map.each { |manager_id,rows|
      rows.each{ |row|
        style = rows_style[i]
        string +="data.setRowProperty("+ (row.to_s) +", 'style', 'background: -webkit-gradient(linear, 0% 0%, 0% 100%, from("+style[:style][:from]+"), to("+style[:style][:to]+"));border: 2px solid "+style[:style][:border]+"');
        "

        string +="data.setRowProperty("+(row.to_s) +", 'selectedStyle', 'background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#FFF7AE), to(#EEE79E));border: 2px solid #E3CA4B');
        "
      }
      i+=1

    }

    string
  end


end
