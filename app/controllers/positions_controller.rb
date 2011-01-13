class PositionsController < ApplicationController
  unloadable

  before_filter :authorize_global

  helper :hr

  def index
    @positions = Position.find(:all)
  end


  def show
    redirect_to :controller => 'positions', :action => 'index'
  end



  def new
    if request.get?
      @position = Position.new()
    else
      @position = Position.new(params[:position])
      @position.title = params[:position][:title]
      @position.manager_id = params[:position][:manager_id]
      if @position.save
        flash[:notice] = l(:notice_successful_create)
        redirect_to(params[:continue] ? {:controller => 'positions', :action => 'new'} :
            {:controller => 'positions', :action => 'index', :id => @position})
        return
      end
    end
  end

  def edit

    @position = Position.find(params[:id])
    if request.post?
      @position.title = params[:position][:title] if params[:position][:title]
      @position.manager_id = params[:position][:manager_id] if params[:position][:manager_id]
      UserPosition.destroy_all( ["position_id=?", @position.id])
      (params[:user_id] || []).each { |user_id|
        #        news.each { |new|
        #          @role.workflows.build(:tracker_id => @tracker.id, :old_status_id => old, :new_status_id => new)
        #        }
        user_position=UserPosition.new
        user_position.position_id=@position.id
        user_position.user_id=user_id
        user_position.save
      }
      if @position.save
        flash[:notice] = l(:notice_successful_update)
        redirect_to :action => 'index'
      end

    end
  rescue ::ActionController::RedirectBackError
    redirect_to :controller => 'positions', :action => 'edit', :id => @position
  end

  def destroy
    @position = Position.find(params[:id])
    @position.destroy
    redirect_to :action => 'index'
  rescue
    flash[:error] =  l(:error_can_not_remove_position)
    redirect_to :action => 'index'
  end

  def chart
    @user_positions =  UserPosition.find(:all)
  end


  
end
