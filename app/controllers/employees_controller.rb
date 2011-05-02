class EmployeesController < ApplicationController
  unloadable

  helper :hr

  helper :custom_fields

  before_filter :authorize_global

  def index
    @users =  @users =  User.find(:all,:joins=> [:position],:order => "positions.position",:conditions => ["status=?", 1])
  end

  def edit
    @user = User.find(params[:id])
    @user_details = UserDetails.find(:first, :conditions => ["user_id=?", @user.id])
    if @user_details == nil
      @user_details = UserDetails.new(:user_id => @user.id)
      @user_details.save
    end

    if request.post? and @user.update_attributes(params[:user_custom_fields]) and @user_details.update_attributes(params[:user_details])
      if @user.save and @user_details.save
        flash[:notice] = l(:notice_successful_update)
      end
    end

  end
end
