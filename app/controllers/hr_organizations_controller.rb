class HrOrganizationsController < ApplicationController
  unloadable

  before_filter :authorize_global

  helper :hr

  helper :custom_fields


  def index
    @hr_organizations=HrOrganization.all(:order => 'lft')
  end

  def new
    @hr_organization = HrOrganization.new
    #@hr_organization.children.build(:name => "test")
  end

  def create
    @hr_organization = HrOrganization.new(params[:hr_organization])
    if @hr_organization.save
      if params[:hr_organization][:parent_id] and params[:hr_organization][:parent_id].to_i >0
        parent=HrOrganization.find(params[:hr_organization][:parent_id])
        @hr_organization.move_to_child_of(parent.id) if parent
      end
      flash[:notice] = "Successfully created hr organization."
      redirect_to @hr_organization
    else
      render :action => 'new'
    end
  end

  def edit
    @hr_organization = HrOrganization.find(params[:id])
  end

  def update
    @hr_organization = HrOrganization.find(params[:id])
    if @hr_organization.update_attributes(params[:hr_organization])
      @hr_organization.assign_parent(params[:hr_organization][:parent_id]) if params[:hr_organization][:parent_id]
      flash[:notice] = l(:notice_successful_update)
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end

  def destroy
    @hr_organization = HrOrganization.find(params[:id])
    @hr_organization.destroy
    flash[:notice] = "Successfully destroyed hr organization."
    redirect_to hr_organizations_url
  end

  def show
    @hr_organization = HrOrganization.find(params[:id])
  end

  def chart
    if params[:id]
      @hr_organization = HrOrganization.find(params[:id])#, :include => [:manager_user_position,:manager,:manager_job_title,:departments])
    else
      @hr_organization = HrOrganization.find(:first)
    end
  end

end
