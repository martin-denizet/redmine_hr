class HrJobTitlesController < ApplicationController
  unloadable

  before_filter :authorize_global

  helper :hr

  helper :custom_fields

  def index
    @job_titles = HrJobTitle.find(:all,:order => 'position')
  end


  def show
    redirect_to :action => 'index'
  end


  def new
    @hr_job_title = HrJobTitle.new
  end

  def edit
    @hr_job_title = HrJobTitle.find(params[:id])
  end

  def update
    @hr_job_title = HrJobTitle.find(params[:id])
    if @hr_job_title.update_attributes(params[:hr_job_title])
      flash[:notice] = l(:notice_successful_update)
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end

  def destroy
    @hr_job_title = HrJobTitle.find(params[:id])
    @hr_job_title.destroy
    flash[:notice] = "Successfully destroyed."
    redirect_to hr_job_titles_url
  end

  def chart
    @users =  User.find(:all,:joins=>:job_title,:order => "#{HrPosition.table_name}.job_title",:conditions => ["status=?", 1])
  end

  def contact_list
    @users =  @users =  User.find(:all,:joins=> [:job_title],:order => "#{HrPosition.table_name}.job_title",:conditions => ["status=?", 1])
  end

  def create
    @hr_job_title = HrJobTitle.new(params[:hr_job_title])
    if @hr_job_title.save
      respond_to do |format|
        format.html do
          flash[:notice] = l(:notice_successful_create)
          redirect_to :action => 'index'
        end
        format.js do
          # IE doesn't support the replace_html rjs method for select box options
          render(:update) {|page| page.replace "hr_#{params[:type]}_manager_user_position_attributes_job_title_id",
            content_tag('select', '<option></option>' +
                options_from_collection_for_select(HrJobTitle.find(:all), 'id', 'title', @hr_job_title.id),
              :id => "hr_#{params[:type]}_manager_user_position_attributes_job_title_id",
              :name => "hr_#{params[:type]}[manager_user_position_attributes][job_title_id]")
          }
        end
      end
    else
      respond_to do |format|
        format.html { render :action => 'new'}
        format.js do
          render(:update) {|page| page.alert(@hr_job_title.errors.full_messages.join('\n')) }
        end
      end
    end
  end

end
