class PositionsController < ApplicationController
  unloadable

  before_filter :authorize_global

  helper :hr

  helper :custom_fields

  def index
    @positions = Position.find(:all,:order => 'position')
  end


  def show
    redirect_to :controller => 'positions', :action => 'index'
  end



  def new
    if request.get?
      @position = Position.new()
      if params[:manager_id]
        @position.manager_id=params[:manager_id]
      end
    else
      @position = Position.new(params[:position])
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

    @position = Position.find(params[:id])
    if request.post? and @position.update_attributes(params[:position])
      
      UserPosition.destroy_all( ["position_id=?", @position.id])

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

  def contact_list
    @user_positions =  UserPosition.find(:all,:order => "position_id")
  end

  
end
