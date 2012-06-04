class HrUserPositionsController < ApplicationController
  unloadable

  helper :hr

  #  def edit
  #    @hr_department = HrDepartment.find(params[:id], :include=>[:user_details,:members])
  #  end

  def autocomplete_for_user

    scope=User.active
    scope=scope.like(params[:q]) if params[:q].present?
    @users=scope.find(:all, :limit => 100, :order => 'login, lastname ASC')
    render :layout => false
  end

  def membership
    @hr_department = HrDepartment.find(params[:id])
  end

  def create
    @hr_department = HrDepartment.find(params[:id])
    user_positions=[]
    user_ids = []
    if params[:hr_department]
      if params[:hr_department][:member_ids]
        attrs = params[:hr_department].dup
        user_ids = attrs.delete(:member_ids)
        user_ids.each do |user_id|
          #user_positions << HrUserPosition.new(:hr_structure => @hr_department, :job_title_id => params[:hr_department][:job_title], :user_id => user_id)
          user_positions << HrUserPosition.new(
            #:hr_structure_type => @hr_department.type,
            #:hr_structure_id => @hr_department.id,
            :job_title_id => params[:hr_department][:job_title], :user_id => user_id)
        end
      end
      @hr_department.user_positions << user_positions
      #@hr_department.members.save
    end

    respond_to do |format|
      if user_positions.present? && user_positions.all? {|m| m.valid? }
        format.html { redirect_to :controller => 'hr_user_positions', :action => 'membership', :id => @hr_department }
        format.js {
          render(:update) {|page|
            page.replace_html "content-department-members", :partial => 'hr_user_positions/multi_form'
            page << 'hideOnLoad()'
            user_ids.each {|member| page.visual_effect(:highlight, "member-#{member}") }
          }
        }
      else
        format.js {
          render(:update) {|page|
            errors = user_positions.collect {|m|
              m.errors.full_messages
            }.flatten.uniq

            page.alert(l(:notice_failed_to_save_members, :errors => errors.join(', ')))
          }
        }
      end
    end
  end


  def update
    @hr_department = HrDepartment.find(params[:id])
    if params[:membership]
      @member.role_ids = params[:membership][:role_ids]
    end
    saved = @member.save
    respond_to do |format|
      format.html { redirect_to :controller => ':hr_user_positions', :action => 'membership', :id => @hr_department  }
      format.js {
        render(:update) {|page|
          page.replace_html "content-department-members", :partial => 'hr_user_positions/multi_form'
          page << 'hideOnLoad()'
          page.visual_effect(:highlight, "member-#{@member.id}")
        }
      }
      format.api {
        if saved
          head :ok
        else
          render_validation_errors(@member)
        end
      }
    end
  end


  def destroy
    @hr_department = HrDepartment.find(params[:hr_department_id])
    @hr_user_position=HrUserPosition.find(params[:id])
    if request.delete?
      @hr_user_position.destroy
    end
    respond_to do |format|
      format.html { redirect_to :controller => ':hr_user_positions', :action => 'membership', :id => @hr_department  }
      format.js { render(:update) {|page|
          page.replace_html "content-department-members", :partial => 'hr_user_positions/multi_form'
          page << 'hideOnLoad()'
        }
      }
    end
  end

end
