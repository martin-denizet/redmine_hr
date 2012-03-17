class PositionsController < ApplicationController
  unloadable

  before_filter :authorize_global

  helper :hr

  helper :custom_fields

  def index
    @positions = HrPosition.find(:all,:order => 'position')
  end


  def show
    redirect_to :controller => 'positions', :action => 'index'
  end


  def new
    if request.get?
      @position = HrPosition.new()
      if params[:manager_id]
        @position.manager_id=params[:manager_id]
      end
    else
      @position = HrPosition.new(params[:position])
      @position.title = params[:position][:title]
      @position.manager_id = params[:position][:manager_id]
      if @position.save
        (params[:user_id] || []).each { |user_id|
          @position.user_positions.build(:position_id => @position.id, :user_id => user_id)
        }

        if @position.save
          flash[:notice] = l(:notice_successful_update)
        end
        redirect_to(params[:continue] ? {:controller => 'positions', :action => 'new', :manager_id => @position.id} :
            {:controller => 'positions', :action => 'index', :id => @position})
        return
      end
    end
  end

  def edit

    @position = HrPosition.find(params[:id])
    if request.post? and @position.update_attributes(params[:position])

      HrUserPosition.destroy_all( ["position_id=?", @position.id])

      (params[:user_id] || []).each { |user_id|
        @position.user_positions.build(:position_id => @position.id, :user_id => user_id)
      }

      if @position.save
        flash[:notice] = l(:notice_successful_update)
      end
      redirect_to :action => 'index'

    end
  rescue ::ActionController::RedirectBackError
    redirect_to :controller => 'positions', :action => 'edit', :id => @position
  end

  def destroy
    @position = HrPosition.find(params[:id])
    @position.destroy
    redirect_to :action => 'index'
  rescue
    flash[:error] =  l(:error_can_not_remove_position)
    redirect_to :action => 'index'
  end

  def chart
    #@user_positions =  UserPosition.find(:all,:order => "position_id")
    @users =  User.find(:all,:joins=>:position,:order => "#{HrPosition.table_name}.position",:conditions => ["status=?", 1])
  end

  def contact_list
    @users =  @users =  User.find(:all,:joins=> [:position],:order => "#{HrPosition.table_name}.position",:conditions => ["status=?", 1])
  end


end
