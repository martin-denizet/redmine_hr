module HrHelper

  def hr_index()
    link_to l(:label_hr), url_for(:controller => 'hr', :action=>'index')
  end
  def hr_organizations_index()
    link_to l(:label_hr_organization_plural), {:controller=>'hr_organizations',:action=>'index'}
  end
  def hr_departments_index()
    link_to l(:label_hr_department_plural), {:controller=>'hr_departments',:action=>'index'}
  end
  def hr_job_titles_index()
    link_to l(:label_hr_job_title_plural), {:controller=>'hr_job_titles',:action=>'index'}
  end


  def link_to_organization(organization, options={}, html_options = nil)
    if organization.active?
      url = {:controller => 'hr_organizations', :action => 'edit', :id => organization}.merge(options)
      link_to(h(organization), url, html_options)
    else
      h(organization)
    end
  end

  def link_to_organization_chart(organization, options={}, html_options = nil)
    if organization.active?
      url = {:controller => 'hr_organizations', :action => 'chart', :id => organization}.merge(options)
      link_to(h(organization), url, html_options)
    else
      h(organization)
    end
  end

  def link_to_department(department, options={}, html_options = nil)
    if department.active?
      url = {:controller => 'hr_departments', :action => 'edit', :id => department}.merge(options)
      link_to(h(department), url, html_options)
    else
      h(department)
    end
  end

  def link_to_structure_manager(structure)
    if structure.active?
      avatar(structure.manager, :size => "16").to_s + link_to_user(structure.manager)+ "(#{structure.manager_job_title})"
    end
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

  def job_titles_for_select(selected)

    positions = HrJobTitle.find(:all)

    collection=[]

    positions.each { |u|
      #  if selected.id!=u.id
      collection << [u.title, u.id]
      #  end
    }

    collection
  end

  def hr_organizations_for_select()

    hr_organizations = HrOrganization.find(:all)
    collection=[]
    hr_organizations.each { |u|
      collection << [u.name, u.id]
    }

    collection
  end

  def hr_departments_for_select()

    hr_departements = HrDepartment.find(:all)
    collection=[]
    hr_departements.each { |u|
      collection << [u.name, u.id]
    }

    collection
  end


  def nested_hr_organizations_for_select(hr_organization=nil)

    nested_set_options(HrOrganization, hr_organization) {|i|
      "#{'–' * i.level} #{i.name}"
    }
  end


  #From awesome nested set
  #  def copy_of_nested_set_options(class_or_item, mover = nil)
  #    class_or_item = class_or_item.roots if class_or_item.is_a?(Class)
  #    items = Array(class_or_item)
  #    result = []
  #    items.each do |root|
  #      result += root.self_and_descendants.map do |i|
  #        if mover.nil? || mover.new_record? || mover.move_possible?(i)
  #          [yield(i), i.id]
  #        end
  #      end.compact
  #    end
  #    result
  #  end

  def users_for_select(selected)

    users = User.find(:all, :conditions => ["status=?", 1])

    #collection = ['None'=>nil]
    collection=[]

    users.each { |u|
      #if selected.id!=u.id
      collection << [u.name, u.id]
      #end
    }

    collection
  end

  def users_check_box_tags(name, users)
    s = ''
    users.sort.each do |user|
      s << "<label>#{ check_box_tag name, user.id, false } #{h user}"
      s << "#{h user.department}" if user.has_attribute?('department')
      s << "</label>\n"
    end
    s.html_safe
  end

  #  def format_chart_user_position(hash)
  #    user_position = hash[:user_position]
  #      "[
  #      {
  #        v:'#{user_position.id}',
  #        f:'<div></div><div class=\"org_chart_avatar\">#{avatar(user_position.user, :size => "60")}</div>\\n <div class=\"org_chart_content\"><p>#{link_to_user user_position.user}</p><p>#{link_to_user user_position.job_title}</p></div>'
  #      },
  #      '#{hash[:parent]}',
  #      ''
  #   ],#"
  #    end


  def rows_style()
    [
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
      {:style => {:'from' => '#F9D9FF', :'to' => '#EFA9FE',:'border' => '#E469FE'}}
    ]
  end



  def users_to_csv(issues, project, query, options={})
    decimal_separator = l(:general_csv_decimal_separator)
    encoding = l(:general_csv_encoding)
    columns = (options[:columns] == 'all' ? query.available_columns : query.columns)

    export = FCSV.generate(:col_sep => l(:general_csv_separator)) do |csv|
      # csv header fields
      csv << [ "#" ] + columns.collect {|c| Redmine::CodesetUtil.from_utf8(c.caption.to_s, encoding) } +
        (options[:description] ? [Redmine::CodesetUtil.from_utf8(l(:field_description), encoding)] : [])

      # csv lines
      issues.each do |issue|
        col_values = columns.collect do |column|
          s = if column.is_a?(QueryCustomFieldColumn)
            cv = issue.custom_field_values.detect {|v| v.custom_field_id == column.custom_field.id}
            show_value(cv)
          else
            value = column.value(issue)
            if value.is_a?(Date)
              format_date(value)
            elsif value.is_a?(Time)
              format_time(value)
            elsif value.is_a?(Float)
              ("%.2f" % value).gsub('.', decimal_separator)
            else
              value
            end
          end
          s.to_s
        end
        csv << [ issue.id.to_s ] + col_values.collect {|c| Redmine::CodesetUtil.from_utf8(c.to_s, encoding) } +
          (options[:description] ? [Redmine::CodesetUtil.from_utf8(issue.description, encoding)] : [])
      end
    end
    export
  end


end
