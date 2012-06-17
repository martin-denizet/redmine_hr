class HrDepartmentsController < ApplicationController
  unloadable

  before_filter :authorize_global

  helper :hr

  #helper :hr_user_positions

  #helper :nested_set_options

  helper :custom_fields


  def index
    if params[:hr_organization]
      @hr_organization=HrOrganization.find(params[:hr_organization].to_i)
    else
      @hr_organization=HrOrganization.roots.first
    end
    if @hr_organization.nil?
      @hr_departments = nil
    else
      @hr_departments = HrDepartment.find(:all, :include=>[:manager_user_position], :conditions=>['organization_id=?',@hr_organization.id])
    end
  end

  def new
    @hr_department = HrDepartment.new
    #@hr_department.children.build(:name => "test")
  end

  def create
    @hr_department = HrDepartment.new(params[:hr_department])
    if @hr_department.save
      if params[:hr_department][:parent_id] and params[:hr_department][:parent_id].to_i >0
        parent=HrDepartment.find(params[:hr_department][:parent_id])
        @hr_department.move_to_child_of(parent.id) if parent
      end
      flash[:notice] = "Successfully created hr organization."
      if params[:continue]
        redirect_to :action => 'new'
      else
        redirect_to :action => 'index', :hr_organization => @hr_department.organization
      end
      
    else
      render :action => 'new'
    end
  end

  def edit
    @hr_department = HrDepartment.find(params[:id])
  end

  def update
    @hr_department = HrDepartment.find(params[:id])
    if @hr_department.update_attributes(params[:hr_department])
      @hr_department.move_to_child_of(params[:hr_department][:parent_id]) if params[:hr_department][:parent_id]
      flash[:notice] = l(:notice_successful_update)
      redirect_to @hr_department
    else
      render :action => 'edit'
    end
  end

  def destroy
    @hr_department = HrDepartment.find(params[:id])
    @hr_department.destroy
    flash[:notice] = "Successfully destroyed hr department."
    redirect_to hr_departments_url
  end

  def show
    @hr_department = HrDepartment.find(params[:id])
  end
  
end